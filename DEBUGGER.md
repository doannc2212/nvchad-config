# NeoVim Debugger Configuration (DAP)

This NeoVim configuration includes comprehensive debugging support for NestJS, Next.js, Golang, and Rust projects using the Debug Adapter Protocol (DAP).

## 🚀 Features

- **Full DAP Support**: Debug Adapter Protocol integration for multiple languages
- **Visual Debugging**: DAP UI with scopes, breakpoints, stacks, watches, and REPL
- **Virtual Text**: Inline display of variable values during debugging
- **Auto UI**: Automatically opens/closes debug UI when debugging starts/stops
- **Multiple Configurations**: Pre-configured launch configurations for different scenarios

## 📦 Installed Plugins

- `nvim-dap`: Core DAP client
- `nvim-dap-ui`: Beautiful UI for debugging
- `nvim-dap-virtual-text`: Inline variable display
- `mason-nvim-dap`: Automatic installation of debug adapters

## 🛠️ Supported Languages & Tools

### 1. **Node.js / TypeScript** (NestJS, Next.js)
- **Adapter**: `js-debug-adapter` (installed via Mason)
- **Debugger**: `pwa-node`

#### Available Configurations:
- **Debug NestJS App**: Runs `npm run start:debug`
- **Debug Next.js Server**: Runs `npm run dev` with Next.js debugging
- **Debug Next.js Full Stack**: Full stack debugging with NODE_OPTIONS
- **Launch Current File**: Debug the current TypeScript/JavaScript file
- **Attach to Node Process**: Attach to running Node.js process
- **Debug Jest Tests**: Run and debug Jest tests

### 2. **Golang**
- **Adapter**: `delve` (installed via Mason)
- **Debugger**: `dlv`

#### Available Configurations:
- **Debug**: Debug current Go file
- **Debug (Go Package)**: Debug entire Go package
- **Debug (Arguments)**: Debug with custom arguments
- **Debug Test**: Debug Go tests in current file
- **Debug Test (Go Package)**: Debug all tests in package
- **Attach to Process**: Attach to running Go process

### 3. **Rust**
- **Adapter**: `codelldb` (installed via Mason)
- **Debugger**: `lldb`

#### Available Configurations:
- **Launch file**: Debug Rust binary (target/debug)
- **Debug Rust Tests**: Build and debug Rust tests
- **Attach to process**: Attach to running Rust process

## ⌨️ Keybindings

### Main Debug Controls

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>db` | Toggle Breakpoint | Set/remove breakpoint at current line |
| `<leader>dB` | Conditional Breakpoint | Set breakpoint with condition |
| `<leader>dc` | Continue | Continue execution (or start debugging) |
| `<leader>dC` | Run to Cursor | Run until cursor position |
| `<leader>di` | Step Into | Step into function |
| `<leader>dO` | Step Over | Step over function |
| `<leader>do` | Step Out | Step out of function |
| `<leader>dt` | Terminate | Stop debugging session |
| `<leader>dr` | Toggle REPL | Open/close debug REPL |
| `<leader>du` | Toggle UI | Open/close DAP UI |
| `<leader>de` | Eval | Evaluate expression under cursor |
| `<leader>dl` | Run Last | Run last debug configuration |
| `<leader>dp` | Pause | Pause execution |

### Function Keys (VSCode-style)

| Key | Action | Description |
|-----|--------|-------------|
| `F5` | Continue | Continue/Start debugging |
| `F10` | Step Over | Step over function |
| `F11` | Step Into | Step into function |
| `F12` | Step Out | Step out of function |

### Visual Mode

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>de` | Eval Selection | Evaluate selected expression |

## 🎯 Usage Guide

### Starting a Debug Session

1. **Open your project file** (TypeScript, Go, Rust, etc.)
2. **Set breakpoints** with `<leader>db`
3. **Start debugging** with `<leader>dc`
4. **Select configuration** from the list

### Example: Debugging NestJS

```typescript
// app.controller.ts
@Controller()
export class AppController {
  @Get()
  getHello(): string {
    // Set breakpoint here with <leader>db
    const message = 'Hello World!';
    return message;
  }
}
```

1. Place cursor on the line you want to debug
2. Press `<leader>db` to set breakpoint (🔴 appears)
3. Press `<leader>dc` to start debugging
4. Select "Debug NestJS App"
5. DAP UI opens automatically
6. Make a request to trigger the breakpoint
7. Use `F10` to step over, `F11` to step into

### Example: Debugging Next.js

```typescript
// app/page.tsx
export default function Home() {
  // Set breakpoint here
  const data = fetchData();
  return <div>{data}</div>;
}
```

1. Set breakpoint with `<leader>db`
2. Press `<leader>dc`
3. Select "Debug Next.js Server"
4. Open browser and navigate to the page
5. Debugger will pause at breakpoint

### Example: Debugging Golang

```go
// main.go
func main() {
    // Set breakpoint here with <leader>db
    message := "Hello, World!"
    fmt.Println(message)
}
```

1. Set breakpoint with `<leader>db`
2. Press `<leader>dc`
3. Select "Debug" or "Debug (Go Package)"
4. Use F10/F11 to step through code

### Example: Debugging Rust

```rust
// main.rs
fn main() {
    // Set breakpoint here with <leader>db
    let message = "Hello, World!";
    println!("{}", message);
}
```

1. Build your project: `cargo build`
2. Set breakpoint with `<leader>db`
3. Press `<leader>dc`
4. Select "Launch file"
5. Enter path to executable (e.g., `./target/debug/myapp`)

## 🔧 Configuration Files

### DAP Configuration
- **File**: `lua/plugins/dap.lua`
- **Contains**: All debugger adapters and launch configurations

### Keybindings
- **File**: `lua/mappings.lua`
- **Contains**: All debug-related keybindings

## 📝 Customizing Configurations

### Adding Custom NestJS Configuration

Edit `lua/plugins/dap.lua` and add to the `dap.configurations.typescript` array:

```lua
{
  type = "pwa-node",
  request = "launch",
  name = "My Custom NestJS Config",
  cwd = "${workspaceFolder}",
  runtimeExecutable = "npm",
  runtimeArgs = { "run", "start:custom" },
  skipFiles = { "<node_internals>/**" },
  console = "integratedTerminal",
}
```

### Adding Custom Go Configuration

Edit `lua/plugins/dap.lua` and add to the `dap.configurations.go` array:

```lua
{
  type = "delve",
  name = "My Custom Go Config",
  request = "launch",
  program = "${workspaceFolder}/cmd/myapp",
  args = { "--port", "8080" },
}
```

## 🎨 DAP UI Layout

The DAP UI is configured with two main layouts:

### Left Panel (40 columns)
- **Scopes**: Local/global variables
- **Breakpoints**: List of all breakpoints
- **Stacks**: Call stack
- **Watches**: Watch expressions

### Bottom Panel (25% height)
- **REPL**: Interactive debugging console
- **Console**: Application output

## 🔍 DAP Signs

The following icons are used in the gutter:

- 🔴 `DapBreakpoint`: Regular breakpoint
- 🟡 `DapBreakpointCondition`: Conditional breakpoint
- 📝 `DapLogPoint`: Log point
- ▶️ `DapStopped`: Current execution line
- ❌ `DapBreakpointRejected`: Invalid breakpoint

## 🚨 Troubleshooting

### Node.js Debugger Not Working

1. Make sure you have the debug script in `package.json`:
```json
{
  "scripts": {
    "start:debug": "nest start --debug --watch"
  }
}
```

2. Check if `js-debug-adapter` is installed:
```vim
:Mason
```
Look for "js-debug-adapter" in the list

### Delve Not Found (Go)

Install delve manually:
```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

### CodeLLDB Not Working (Rust)

Install via Mason:
```vim
:DapInstall codelldb
```

Or manually:
```bash
# Check Mason's installation path
ls ~/.local/share/nvim/mason/bin/codelldb
```

### Source Maps Not Working (TypeScript)

Ensure `tsconfig.json` has source maps enabled:
```json
{
  "compilerOptions": {
    "sourceMap": true
  }
}
```

## 📚 Additional Resources

- [nvim-dap Documentation](https://github.com/mfussenegger/nvim-dap)
- [NestJS Debugging Guide](https://docs.nestjs.com/techniques/debugging)
- [Next.js Debugging](https://nextjs.org/docs/advanced-features/debugging)
- [Delve Documentation](https://github.com/go-delve/delve)
- [CodeLLDB Documentation](https://github.com/vadimcn/codelldb)

## 💡 Tips

1. **Use conditional breakpoints** for complex debugging scenarios
2. **Evaluate expressions** with `<leader>de` to inspect values
3. **Use REPL** (`<leader>dr`) to execute code during debugging
4. **Watch expressions** to monitor specific variables
5. **Attach to processes** for debugging running applications
6. **Step through code** efficiently with F10 (over) and F11 (into)

## 🔄 Installation

After adding the configuration, restart NeoVim and run:

```vim
:Lazy sync
```

Mason will automatically install the required debug adapters:
- `js-debug-adapter` (Node.js/TypeScript)
- `delve` (Go)
- `codelldb` (Rust)

Happy Debugging! 🐛🔍

