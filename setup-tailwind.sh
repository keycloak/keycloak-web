#!/bin/bash

echo "🎨 Setting up Tailwind CSS for Keycloak Website"
echo "================================================"
echo ""

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install Node.js and npm first."
    exit 1
fi

echo "📦 Installing dependencies..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ Failed to install npm dependencies"
    exit 1
fi

echo ""
echo "🎨 Building Tailwind CSS..."
npm run build:css

if [ $? -ne 0 ]; then
    echo "❌ Failed to build Tailwind CSS"
    exit 1
fi

echo ""
echo "✅ Tailwind CSS setup complete!"
echo ""
echo "Next steps:"
echo "  1. Run 'npm run watch:css' to watch for CSS changes during development"
echo "  2. Run './build-local.sh' to build with local paths"
echo "  3. Run 'npm run serve' to start local development server"
echo ""
echo "📚 See TAILWIND_MIGRATION.md for usage guide"
echo ""
