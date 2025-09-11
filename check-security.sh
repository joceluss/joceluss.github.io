#!/bin/bash

# Security check script for the joceluss.github.io project
# This script checks for security vulnerabilities in dependencies and code

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Running security checks for joceluss.github.io"
echo "================================================"

# Create security reports directory
mkdir -p security-reports

# 1. Check Python dependencies with safety (deprecated command)
echo -e "\n${YELLOW}1. Checking Python dependencies with safety...${NC}"
if command -v safety &> /dev/null; then
    timeout 30 safety scan --json > security-reports/safety-report.json 2>&1 || echo "⚠️  Safety scan timed out or failed - may have network issues"
    if [ -f "security-reports/safety-report.json" ]; then
        echo "✅ Safety report saved to security-reports/safety-report.json"
    fi
else
    echo "❌ Safety not installed"
fi

# 2. Check Python dependencies with pip-audit
echo -e "\n${YELLOW}2. Checking Python dependencies with pip-audit...${NC}"
if command -v pip-audit &> /dev/null; then
    pip-audit --format=json --output=security-reports/pip-audit-report.json || echo "Pip-audit completed"
    echo "✅ Pip-audit report saved to security-reports/pip-audit-report.json"
else
    echo "❌ Pip-audit not installed"
fi

# 3. Check Python code with bandit
echo -e "\n${YELLOW}3. Checking Python code with bandit...${NC}"
if command -v bandit &> /dev/null; then
    if [ -d "mkdocs-material" ]; then
        bandit -r mkdocs-material/ -f json -o security-reports/bandit-report.json 2>/dev/null || true
        echo "✅ Bandit report saved to security-reports/bandit-report.json"
    else
        echo "⚠️  No Python code found to scan"
    fi
else
    echo "❌ Bandit not installed"
fi

# 4. Check JavaScript dependencies with npm audit
echo -e "\n${YELLOW}4. Checking JavaScript dependencies with npm audit...${NC}"
if [ -f "mkdocs-material/package.json" ] && command -v npm &> /dev/null; then
    cd mkdocs-material
    npm audit --json > ../security-reports/npm-audit-report.json 2>&1 || true
    cd ..
    echo "✅ NPM audit report saved to security-reports/npm-audit-report.json"
else
    echo "⚠️  No JavaScript dependencies found or npm not installed"
fi

# 5. Generate summary report
echo -e "\n${YELLOW}5. Generating security summary...${NC}"

# Create summary
cat > security-reports/security-summary.md << EOF
# Security Scan Summary

Generated on: $(date)

## Scan Results

### Python Dependencies (pip-audit)
$(python3 -c "
import json
try:
    with open('security-reports/pip-audit-report.json', 'r') as f:
        data = json.load(f)
    vulns = [dep for dep in data['dependencies'] if dep['vulns']]
    if vulns:
        print(f'❌ Found {len(vulns)} packages with vulnerabilities')
        for pkg in vulns:
            print(f'  - {pkg[\"name\"]} ({pkg[\"version\"]}): {len(pkg[\"vulns\"])} vulnerabilities')
    else:
        print('✅ No vulnerabilities found')
except Exception as e:
    print(f'⚠️  Could not parse pip-audit report: {e}')
")

### Python Code Security (bandit)
$(python3 -c "
import json
try:
    with open('security-reports/bandit-report.json', 'r') as f:
        data = json.load(f)
    total_issues = data['metrics']['_totals']['SEVERITY.HIGH'] + data['metrics']['_totals']['SEVERITY.MEDIUM'] + data['metrics']['_totals']['SEVERITY.LOW']
    if total_issues > 0:
        print(f'❌ Found {total_issues} security issues')
        print(f'  - High: {data[\"metrics\"][\"_totals\"][\"SEVERITY.HIGH\"]}')
        print(f'  - Medium: {data[\"metrics\"][\"_totals\"][\"SEVERITY.MEDIUM\"]}')
        print(f'  - Low: {data[\"metrics\"][\"_totals\"][\"SEVERITY.LOW\"]}')
    else:
        print('✅ No security issues found in Python code')
except Exception as e:
    print(f'⚠️  Could not parse bandit report: {e}')
")

### JavaScript Dependencies (npm audit)
$(python3 -c "
import json
try:
    with open('security-reports/npm-audit-report.json', 'r') as f:
        data = json.load(f)
    vulns = data.get('vulnerabilities', {})
    if vulns:
        total = len(vulns)
        high = sum(1 for v in vulns.values() if v.get('severity') == 'high')
        moderate = sum(1 for v in vulns.values() if v.get('severity') == 'moderate')
        low = sum(1 for v in vulns.values() if v.get('severity') == 'low')
        print(f'❌ Found {total} packages with vulnerabilities')
        print(f'  - High: {high}')
        print(f'  - Moderate: {moderate}')
        print(f'  - Low: {low}')
    else:
        print('✅ No vulnerabilities found')
except Exception as e:
    print(f'⚠️  Could not parse npm audit report: {e}')
")

## Recommendations

1. **Update dependencies regularly**: Keep all dependencies up to date
2. **Review vulnerability reports**: Check the detailed reports in the security-reports/ directory
3. **Run security checks before deployment**: Include this script in your CI/CD pipeline
4. **Monitor for new vulnerabilities**: Set up automated security monitoring

## How to fix vulnerabilities

### Python Dependencies
- Review pip-audit-report.json for specific package versions to update
- Update requirements.txt with fixed versions
- Run \`pip install -r requirements.txt\` to install updates

### JavaScript Dependencies
- Review npm-audit-report.json for specific packages
- Run \`npm audit fix\` in the mkdocs-material directory to auto-fix issues
- Update package.json manually for packages that can't be auto-fixed

### Code Security Issues
- Review bandit-report.json for specific security issues in Python code
- Fix identified security patterns and anti-patterns
EOF

echo "✅ Security summary saved to security-reports/security-summary.md"

echo -e "\n${GREEN}🎉 Security checks completed!${NC}"
echo -e "${GREEN}📊 Check security-reports/security-summary.md for a summary${NC}"
echo -e "${GREEN}📁 Detailed reports are in the security-reports/ directory${NC}"

# Show summary
echo -e "\n${YELLOW}Quick Summary:${NC}"
cat security-reports/security-summary.md | grep -E '✅|❌|⚠️' | head -10