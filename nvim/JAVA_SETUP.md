# Java & Spring Boot Development Setup for Neovim

Complete guide for configuring Neovim as a powerful Java IDE with LSP, testing, and Spring Boot support.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [LSP Configuration](#lsp-configuration)
3. [Essential Plugins](#essential-plugins)
4. [Java-Specific Keybindings](#java-specific-keybindings)
5. [Testing Workflow](#testing-workflow)
6. [Spring Boot Integration](#spring-boot-integration)
7. [Build Tool Integration](#build-tool-integration)
8. [Debugging Setup](#debugging-setup)

---

## Prerequisites

### Required Tools

Install these tools before configuring Neovim:

```bash
# Java Development Kit (17 or 21 for modern Spring Boot)
brew install openjdk@17

# Build tools
brew install maven
brew install gradle

# Code search and navigation
brew install ripgrep
brew install fd

# Optional but recommended
brew install jq          # JSON parsing for configs
brew install tree        # Directory visualization
```

### Java Environment

Ensure JAVA_HOME is set:

```bash
# Add to ~/.zshrc or ~/.bashrc
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"
```

Verify installation:

```bash
java -version    # Should show Java 17.x
mvn -version     # Should show Maven 3.x
```

---

## LSP Configuration

### Install jdtls (Java Language Server)

**Option 1: Using mason.nvim (Recommended)**

```lua
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'jdtls',        -- Java
    'lua_ls',       -- Lua (for Neovim config)
  }
})
```

Then run `:Mason` and jdtls will auto-install.

**Option 2: Manual Installation**

```bash
brew install jdtls
```

### jdtls Configuration

Create `~/.config/nvim/ftplugin/java.lua`:

```lua
local jdtls = require('jdtls')

-- Determine workspace directory based on project
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. project_name

-- Find Java installation
local java_home = os.getenv('JAVA_HOME') or '/usr/lib/jvm/default-java'

-- jdtls configuration
local config = {
  cmd = {
    java_home .. '/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob('/path/to/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', '/path/to/jdtls/config_mac',
    '-data', workspace_dir,
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  init_options = {
    bundles = {},
  },
}

-- Start jdtls
jdtls.start_or_attach(config)

-- Java-specific keymaps
local opts = { buffer = 0 }
vim.keymap.set('n', '<leader>co', jdtls.organize_imports, { buffer = 0, desc = 'Organize imports' })
vim.keymap.set('n', '<leader>cv', jdtls.extract_variable, { buffer = 0, desc = 'Extract variable' })
vim.keymap.set('n', '<leader>cc', jdtls.extract_constant, { buffer = 0, desc = 'Extract constant' })
vim.keymap.set('v', '<leader>cm', jdtls.extract_method, { buffer = 0, desc = 'Extract method' })
```

### Alternative: Simple LSP Setup

If you prefer a simpler setup using nvim-lspconfig:

```lua
require('lspconfig').jdtls.setup({
  cmd = { 'jdtls' },
  root_dir = require('lspconfig.util').root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml'),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
        },
      },
    },
  },
})
```

---

## Essential Plugins

### Plugin Manager (lazy.nvim)

```lua
-- ~/.config/nvim/lua/plugins/java.lua
return {
  -- Java LSP
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },

  -- Testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-junit',
      'nvim-lua/plenary.nvim',
    },
  },

  -- Spring Boot support
  {
    'JavaHello/spring-boot.nvim',
    ft = 'java',
    dependencies = {
      'mfussenegger/nvim-jdtls',
    },
  },

  -- Lombok support (syntax highlighting)
  {
    'mcarvalho/vim-lombok',
    ft = 'java',
  },

  -- Maven integration
  {
    'mikelue/vim-maven-plugin',
    ft = 'java',
  },
}
```

### Code Completion

Ensure you have a completion plugin configured:

```lua
{
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',       -- LSP completion
    'hrsh7th/cmp-buffer',          -- Buffer words
    'hrsh7th/cmp-path',            -- File paths
    'L3MON4D3/LuaSnip',            -- Snippets
    'saadparwaiz1/cmp_luasnip',
  },
}
```

### Treesitter for Java

```lua
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'java',
    'kotlin',  -- If using Kotlin
  },
  highlight = { enable = true },
  indent = { enable = true },
})
```

---

## Java-Specific Keybindings

Add these to your `ftplugin/java.lua` or main keymaps:

```lua
-- Java-specific keymaps (only active in Java files)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    local jdtls = require('jdtls')
    local opts = { buffer = true }

    -- Organize imports
    vim.keymap.set('n', '<leader>co', jdtls.organize_imports, 
      { buffer = true, desc = '[C]ode [O]rganize imports' })

    -- Extract variable
    vim.keymap.set('n', '<leader>cv', jdtls.extract_variable, 
      { buffer = true, desc = '[C]ode extract [V]ariable' })

    -- Extract constant
    vim.keymap.set('n', '<leader>cc', jdtls.extract_constant, 
      { buffer = true, desc = '[C]ode extract [C]onstant' })

    -- Extract method
    vim.keymap.set('v', '<leader>cm', jdtls.extract_method, 
      { buffer = true, desc = '[C]ode extract [M]ethod' })

    -- Test class/method
    vim.keymap.set('n', '<leader>tc', jdtls.test_class, 
      { buffer = true, desc = '[T]est [C]lass' })
    vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method, 
      { buffer = true, desc = '[T]est [M]ethod' })
  end,
})
```

---

## Testing Workflow (TDD)

### Neotest Setup

```lua
require('neotest').setup({
  adapters = {
    require('neotest-junit')({
      junit_jar = vim.fn.stdpath('data') .. '/junit-platform-console-standalone.jar',
    }),
  },
})

-- Test keybindings
vim.keymap.set('n', '<leader>tt', require('neotest').run.run, 
  { desc = '[T]est run nearest' })
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, 
  { desc = '[T]est [F]ile' })
vim.keymap.set('n', '<leader>ts', require('neotest').summary.toggle, 
  { desc = '[T]est [S]ummary' })
vim.keymap.set('n', '<leader>to', require('neotest').output.open, 
  { desc = '[T]est [O]utput' })
```

### TDD Workflow Example

1. **Mark test file with Harpoon:**
   ```
   # In UserServiceTest.java
   <Tab>a
   ```

2. **Write test first:**
   ```java
   @Test
   void shouldCreateUser() {
       // Given
       var dto = new UserDTO("john@example.com", "John");
       
       // When
       var result = userService.create(dto);
       
       // Then
       assertThat(result).isNotNull();
   }
   ```

3. **Run test (it should fail):**
   ```
   <leader>tt
   ```

4. **Switch to implementation:**
   ```
   <Tab>]  # or <leader>ff to find UserService.java
   ```

5. **Implement feature:**
   ```java
   public User create(UserDTO dto) {
       // Implementation
   }
   ```

6. **Return to test and re-run:**
   ```
   <Tab>[
   <leader>tt
   ```

7. **Iterate until green**

---

## Spring Boot Integration

### Application Properties Support

Add YAML/Properties syntax and completion:

```lua
{
  'b0o/SchemaStore.nvim',  -- JSON schemas
}

require('lspconfig').yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/application.json"] = "application.yml",
      },
    },
  },
})
```

### Running Spring Boot Application

Create a terminal command:

```lua
vim.keymap.set('n', '<leader>rs', function()
  vim.cmd('split | terminal mvn spring-boot:run')
  vim.cmd('resize 15')
end, { desc = '[R]un [S]pring Boot' })
```

Or use tmux with Harpoon:

1. Mark `Application.java`
2. Open terminal: `<leader>t`
3. Run: `mvn spring-boot:run`
4. Return to code with `<Tab>s`

### REST Client Integration

Use HTTP files with `rest.nvim`:

```lua
{
  'rest-nvim/rest.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

vim.keymap.set('n', '<leader>hr', '<Plug>RestNvim', { desc = '[H]TTP [R]equest' })
```

Create `test-api.http`:

```http
### Get all users
GET http://localhost:8080/api/users

### Create user
POST http://localhost:8080/api/users
Content-Type: application/json

{
  "email": "test@example.com",
  "name": "Test User"
}
```

Place cursor on request and hit `<leader>hr` to execute.

---

## Build Tool Integration

### Maven Commands

Quick Maven commands via terminal or create keymaps:

```lua
-- Maven keybindings
vim.keymap.set('n', '<leader>mc', ':!mvn clean<CR>', { desc = '[M]aven [C]lean' })
vim.keymap.set('n', '<leader>mi', ':!mvn clean install<CR>', { desc = '[M]aven [I]nstall' })
vim.keymap.set('n', '<leader>mt', ':!mvn test<CR>', { desc = '[M]aven [T]est' })
vim.keymap.set('n', '<leader>mp', ':!mvn package<CR>', { desc = '[M]aven [P]ackage' })
```

### Gradle Commands

```lua
-- Gradle keybindings
vim.keymap.set('n', '<leader>gb', ':!./gradlew build<CR>', { desc = '[G]radle [B]uild' })
vim.keymap.set('n', '<leader>gt', ':!./gradlew test<CR>', { desc = '[G]radle [T]est' })
vim.keymap.set('n', '<leader>gr', ':!./gradlew bootRun<CR>', { desc = '[G]radle [R]un' })
```

### Background Build Runner

For continuous testing during TDD:

```lua
vim.keymap.set('n', '<leader>mw', function()
  vim.cmd('split | terminal mvn test-compile -Dmaven.test.skip=true -DskipTests')
  vim.cmd('resize 10')
end, { desc = '[M]aven [W]atch compile' })
```

---

## Debugging Setup

### nvim-dap Configuration

```lua
{
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
  },
}

local dap = require('dap')

-- Java debug configuration
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

-- Keybindings
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
```

Run Spring Boot in debug mode:

```bash
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
```

---

## Common Java Workflows

### Implementing a REST Controller

1. Create test first: `UserControllerTest.java`
2. Mark test with Harpoon: `<Tab>a`
3. Write test for GET endpoint
4. Create controller: `<leader>ff` → `UserController.java`
5. Mark controller: `<Tab>a`
6. Use `<leader>ca` to implement required imports
7. Toggle between test/impl: `<Tab>[` and `<Tab>]`

### Refactoring a Service Method

1. Find all usages: `gr`
2. Check implementations: `gi`
3. Rename if needed: `<leader>rn`
4. Extract method: visual select + `<leader>cm`
5. Organize imports: `<leader>co`

### Exploring a Dependency

1. Place cursor on import
2. `gd` to go to class definition
3. `fm` to list all methods
4. `K` to read JavaDoc
5. `<C-o>` to jump back

---

## Performance Tips

### Optimize jdtls for Large Projects

```lua
-- In jdtls config
cmd = {
  'java',
  '-Xmx4g',  -- Increase heap size for large projects
  '-XX:+UseG1GC',
  -- ... rest of config
}
```

### Exclude Unnecessary Directories

Add to `.gitignore` and jdtls will respect it:

```
target/
.idea/
*.class
.DS_Store
```

---

## Troubleshooting

### jdtls Not Starting

1. Check Java version: `java -version`
2. Verify jdtls installation: `:Mason`
3. Check logs: `:LspLog`
4. Ensure workspace directory is writable

### Completion Not Working

1. Restart LSP: `:LspRestart`
2. Check LSP status: `:LspInfo`
3. Verify cmp sources are configured
4. Try manual completion: `<C-Space>`

### Tests Not Running

1. Ensure Maven/Gradle wrapper is executable: `chmod +x mvnw`
2. Check Java version matches project requirements
3. Verify test dependencies in `pom.xml` or `build.gradle`

---

## Additional Resources

- [nvim-jdtls Documentation](https://github.com/mfussenegger/nvim-jdtls)
- [Spring Boot Neovim Plugin](https://github.com/JavaHello/spring-boot.nvim)
- [Java Style Guide](https://google.github.io/styleguide/javaguide.html)

---

*This setup follows TDD principles and KISS philosophy: Start simple, enhance as needed.*

