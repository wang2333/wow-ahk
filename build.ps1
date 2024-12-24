# Build release version
cargo build --release

# Create release directory
$release_dir = "release"
if (!(Test-Path $release_dir)) {
    New-Item -ItemType Directory -Path $release_dir
}

# Create resources directory in release
$resources_dir = "$release_dir\resources"
if (!(Test-Path $resources_dir)) {
    New-Item -ItemType Directory -Path $resources_dir
}

# Copy files
Copy-Item "target\release\screen-monitor.exe" $release_dir
Copy-Item "config.json" $release_dir

# Copy resource files
Copy-Item "resources\mode1.wav" $resources_dir
Copy-Item "resources\mode2.wav" $resources_dir
Copy-Item "resources\pause.wav" $resources_dir

# Create start.bat
Set-Content -Path "$release_dir\start.bat" -Value "@echo off`nstart screen-monitor.exe" -Encoding ASCII

Write-Output "Build completed! Files are in $release_dir"