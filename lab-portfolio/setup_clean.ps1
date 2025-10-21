param(
    [switch]$Git,
    [string]$Remote = "",
    [switch]$NoDevStart
)

function Require-Cmd($name) {
    try {
        $null = Get-Command $name -ErrorAction Stop
        return $true
    } catch {
        Write-Host "Required command not found: $name"
        return $false
    }
}

Write-Host "Digital Laboratory Setup (PowerShell)"

# 1) Checks
$okNode = Require-Cmd "node"
$okNpm  = Require-Cmd "npm"
if (-not ($okNode -and $okNpm)) {
    Write-Host "Please install Node.js from https://nodejs.org/ and re-run this script."
    exit 1
}

# 2) Must be run in a folder with package.json
if (-not (Test-Path -Path "./package.json")) {
    Write-Host "package.json not found. Run this script from your project root (same folder as package.json)."
    Write-Host "If you have not created the project yet:"
    Write-Host "  npm create vite@latest lab-portfolio -- --template react-swc-ts"
    exit 1
}

# 3) Install dependencies
Write-Host "Installing dependencies (npm install)..."
npm install
if ($LASTEXITCODE -ne 0) { Write-Host "npm install failed."; exit 1 }

Write-Host "Installing dev dependencies..."
npm install -D tailwindcss postcss autoprefixer @vitejs/plugin-react typescript vite
if ($LASTEXITCODE -ne 0) { Write-Host "Dev dependency install failed."; exit 1 }

Write-Host "Installing runtime dependencies..."
npm install framer-motion react-router-dom
if ($LASTEXITCODE -ne 0) { Write-Host "Runtime dependency install failed."; exit 1 }

# 4) Tailwind init if needed
if (-not (Test-Path "./tailwind.config.cjs") -and -not (Test-Path "./tailwind.config.js")) {
    Write-Host "Initializing Tailwind (npx tailwindcss init -p)..."
    npx tailwindcss init -p
}

# 5) Optional Git setup
if ($Git) {
    if (-not (Require-Cmd "git")) {
        Write-Host "Skipping Git setup: git is not installed."
    } else {
        Write-Host "Initializing Git repository..."
        git init
        git add .
        git commit -m "chore: initial commit (Digital Laboratory portfolio)"
        git branch -M main
        if ($Remote -ne "") {
            git remote remove origin 2>$null | Out-Null
            git remote add origin $Remote
            Write-Host "Pushing to remote..."
            git push -u origin main
        } else {
            Write-Host "Tip: re-run with -Git -Remote (your-remote-url) to push automatically."
        }
    }
}

# 6) Start dev server unless suppressed
if (-not $NoDevStart) {
    Write-Host "Starting Vite dev server (npm run dev)..."
    npm run dev
} else {
    Write-Host "Setup complete. Start later with: npm run dev"
}
