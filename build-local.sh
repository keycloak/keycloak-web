#!/bin/bash

echo "🔨 Building Keycloak Website for Local Development"
echo "=================================================="
echo ""

# Set KC_URL to empty string for relative paths
export KC_URL=""

echo "📦 Building Tailwind CSS..."
npm run build:css

if [ $? -ne 0 ]; then
    echo "❌ Failed to build Tailwind CSS"
    exit 1
fi

echo ""
echo "🏗️  Building website with Maven..."
mvn package

if [ $? -ne 0 ]; then
    echo "❌ Failed to build website"
    exit 1
fi

echo ""
echo "✅ Build complete!"
echo ""
echo "🌐 To preview the website:"
echo "   npm run serve"
echo ""
echo "   Then visit:"
echo "   - http://localhost:5000/index.html (original)"
echo "   - http://localhost:5000/index-modern.html (modern)"
echo ""
