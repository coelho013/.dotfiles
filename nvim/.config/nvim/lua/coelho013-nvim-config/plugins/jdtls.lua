return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',

  config = function()
    local function start_jdtls()
      -- listas internas tem a mesma prioridade; a ordem externa decide. Assim, num projeto
      -- multi-modulo, a raiz (wrapper/settings.gradle) ganha do pom.xml do submodulo
      local root_dir = vim.fs.root(0, {
        { 'mvnw', 'gradlew', 'settings.gradle', 'settings.gradle.kts' },
        '.git',
        { 'pom.xml', 'build.gradle', 'build.gradle.kts' },
      })
      if not root_dir then
        return
      end

      -- cada projeto precisa de um workspace proprio, senao o jdtls mistura os indices.
      -- usa o caminho completo para dois projetos com o mesmo nome de pasta nao colidirem
      local project_name = root_dir:gsub('[/\\:]', '_')
      local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. project_name

      local cmd = { 'jdtls', '-data', workspace_dir }

      -- lombok so entra se o jar existir (:MasonInstall lombok-nightly)
      local lombok = vim.fn.stdpath('data') .. '/mason/packages/lombok-nightly/lombok.jar'
      if vim.uv.fs_stat(lombok) then
        table.insert(cmd, '--jvm-arg=-javaagent:' .. lombok)
      end

      require('jdtls').start_or_attach({
        cmd = cmd,
        root_dir = root_dir,
        capabilities = require('blink.cmp').get_lsp_capabilities(),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            inlayHints = { parameterNames = { enabled = 'literals' } },
            -- abre o codigo de classes de bibliotecas (jdt://) decompilado
            contentProvider = { preferred = 'fernflower' },
            completion = {
              -- sugere esses metodos estaticos sem precisar importar antes
              favoriteStaticMembers = {
                'org.junit.jupiter.api.Assertions.*',
                'org.junit.Assert.*',
                'org.mockito.Mockito.*',
                'org.mockito.ArgumentMatchers.*',
                'org.hamcrest.Matchers.*',
                'java.util.Objects.requireNonNull',
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            configuration = {
              -- JDKs usados para compilar os projetos (o jdtls em si roda com Java 21+)
              -- so registra os JDKs que existem na maquina
              runtimes = vim.tbl_filter(function(runtime)
                return vim.uv.fs_stat(runtime.path) ~= nil
              end, {
                { name = 'JavaSE-21', path = '/usr/lib/jvm/java-21-openjdk-amd64' },
                { name = 'JavaSE-17', path = '/usr/lib/jvm/java-17-openjdk-amd64', default = true },
                { name = 'JavaSE-1.8', path = '/usr/lib/jvm/java-8-openjdk-amd64' },
              }),
            },
          },
        },
      })
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      group = vim.api.nvim_create_augroup('coelho013-jdtls', { clear = true }),
      callback = start_jdtls,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('coelho013-jdtls-keymaps', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= 'jdtls' then
          return
        end

        local jdtls = require('jdtls')
        local opts = { buffer = args.buf }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { buffer = args.buf, desc = 'Organizar imports' })
        vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { buffer = args.buf, desc = 'Extrair variavel' })
        vim.keymap.set('v', '<leader>jv', function() jdtls.extract_variable(true) end, { buffer = args.buf, desc = 'Extrair variavel' })
        vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, { buffer = args.buf, desc = 'Extrair constante' })
        vim.keymap.set('v', '<leader>jm', function() jdtls.extract_method(true) end, { buffer = args.buf, desc = 'Extrair metodo' })

        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        vim.keymap.set('n', '<leader>jh', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
        end, { buffer = args.buf, desc = 'Alternar inlay hints' })
      end,
    })

    -- o lazy carrega o plugin no primeiro FileType java, entao inicia no buffer atual tambem
    if vim.bo.filetype == 'java' then
      start_jdtls()
    end
  end,
}
