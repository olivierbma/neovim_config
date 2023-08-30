return {

	'm4xshen/autoclose.nvim',
	config = function()
		-- autoclose bracket pairs
		require('autoclose').setup {
			keys = {
				["("] = { escape = true, close = true, pair = "()" },
				["'"] = { escape = true, close = true, pair = "''" },
				["{"] = { escape = true, close = true, pair = "{}" },
				["["] = { escape = true, close = true, pair = "[]" },
				["\""] = { escape = true, close = true, pair = "\"\"" },
			}

		}
	end,
}
