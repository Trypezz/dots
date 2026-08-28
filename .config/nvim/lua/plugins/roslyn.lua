-- C# via Roslyn (not OmniSharp). Needs Crashdummyy mason registry (mason.lua).

local mason = vim.fn.stdpath("data") .. "/mason"
local roslyn_bin = mason .. "/bin/roslyn-language-server"
local dotnet_root = vim.env.DOTNET_ROOT
	or (vim.fn.isdirectory("/usr/share/dotnet") == 1 and "/usr/share/dotnet")
	or (vim.fn.executable("dotnet") == 1 and vim.fn.fnamemodify(vim.fn.exepath("dotnet"), ":h"))
	or nil

if dotnet_root and not vim.env.DOTNET_ROOT then
	vim.env.DOTNET_ROOT = dotnet_root
end

-- Mason shims (roslyn, csharpier, …) must be on PATH for the LSP cmd
vim.env.PATH = mason .. "/bin:" .. (vim.env.PATH or "")

local cmd = vim.fn.executable(roslyn_bin) == 1 and { roslyn_bin, "--stdio" } or { "roslyn-language-server", "--stdio" }

vim.lsp.config("roslyn", {
	cmd = cmd,
	cmd_env = {
		DOTNET_ROOT = dotnet_root,
		DOTNET_CLI_HOME = vim.env.DOTNET_CLI_HOME or vim.fn.expand("~/.dotnet"),
		PATH = vim.env.PATH,
		-- Prefer Debug analysis so it matches local builds
		Configuration = vim.env.Configuration or "Debug",
	},
	settings = {
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			csharp_enable_inlay_hints_for_lambda_parameter_types = true,
			csharp_enable_inlay_hints_for_types = true,
			dotnet_enable_inlay_hints_for_indexer_parameters = true,
			dotnet_enable_inlay_hints_for_literal_parameters = true,
			dotnet_enable_inlay_hints_for_object_creation_parameters = true,
			dotnet_enable_inlay_hints_for_other_parameters = true,
			dotnet_enable_inlay_hints_for_parameters = true,
		},
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
			dotnet_enable_tests_code_lens = true,
		},
		["csharp|completion"] = {
			dotnet_show_completion_items_from_unimported_namespaces = true,
			dotnet_show_name_completion_suggestions = true,
		},
		["csharp|background_analysis"] = {
			background_analysis_dotnet_analyzer_diagnostics_scope = "openFiles",
			background_analysis_dotnet_compiler_diagnostics_scope = "openFiles",
		},
	},
})

-- Never enable lspconfig's alternate roslyn_ls (conflicts with roslyn.nvim)
vim.lsp.enable("roslyn_ls", false)

return {
	{
		"seblyng/roslyn.nvim",
		lazy = false,
		opts = {
			-- Let Roslyn watch files; more reliable project reloads
			filewatching = "roslyn",
			-- Find .sln even when nested oddly
			broad_search = true,
		},
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				cs = { "csharpier" },
			},
		},
	},
}
