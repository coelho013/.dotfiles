return {
	'nvim-mini/mini.map',
	version = '*',
	config = function()
		local map = require('mini.map')
		map.setup({
			integrations = {
				map.gen_integration.diff()
			},
			symbols = {
				encode = map.gen_encode_symbols.dot('3x2')
			},
			window = {
				width = 15
			}
		})

		vim.api.nvim_create_autocmd('CursorMovedI', {
				callback = function(ev)
					 MiniMap.refresh()
				end
		})

		vim.api.nvim_create_autocmd('BufAdd', {
			callback = function(ev)
				MiniMap.open()
			end 
		})

		vim.keymap.set('n', '<Leader>mc', MiniMap.close)
		vim.keymap.set('n', '<Leader>mo', MiniMap.open)
		vim.keymap.set('n', '<Leader>mr', MiniMap.refresh)
		vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus)
	end
}
