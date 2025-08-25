-- IntelliJ-style formatting
vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.shiftwidth = 4 -- Number of spaces for each indent
vim.bo.tabstop = 4 -- Number of spaces a tab counts for
vim.bo.softtabstop = 4 -- Spaces inserted/deleted with Tab/BS
vim.bo.smartindent = true -- Enable smart indenting
vim.bo.autoindent = true -- Auto-indent new lines
-- local config = {
-- 	cmd = { vim.fn.expand("/Users/mohammadrehan/.local/share/nvim/mason/bin/jdtls") },
-- 	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
-- }
-- require("jdtls").start_or_attach(config)
--
--
--
local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name
-- local path_to_java_dap =
-- 	"/Users/mohammadrehan/.m2/repository/com/microsoft/java/com.microsoft.java.debug.plugin/0.53.2/com.microsoft.java.debug.plugin-0.53.2.jar"
-- local path_to_java_dap = "/Users/mohammadrehan/Downloads/java-debug-main/com.microsoft.java.debug.plugin/target"

local cwd = vim.fn.getcwd()

local java_path = "java" -- default

if cwd:find("Apple") then
	-- java_path = "/Library/Java/JavaVirtualMachines/applejdk-17.0.14.7.3.jdk/Contents/Home/bin/java"
	java_path = "/Library/Java/JavaVirtualMachines/applejdk-17.0.14.7.3.jdk/Contents/Home/bin/java"
end

local status, jdtls = pcall(require, "jdtls")
if not status then
	print("there is no jdtls")
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	cmd = {
		java_path,
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_mac",
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = true,
			},
		},
	},

	init_options = {
		bundles = {
			"Users/mohammadrehan/Downloads/java-debug-main/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.2.jar",
		},
	},
}
jdtls.start_or_attach(config)

vim.keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
vim.keymap.set("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
vim.keymap.set(
	"v",
	"<leader>crv",
	"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
	{ desc = "Extract Variable" }
)
vim.keymap.set("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
vim.keymap.set(
	"v",
	"<leader>crc",
	"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
	{ desc = "Extract Constant" }
)
vim.keymap.set(
	"v",
	"<leader>crm",
	"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
	{ desc = "Extract Method" }
)
