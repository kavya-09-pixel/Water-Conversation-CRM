# Water Conservation CRM

A Salesforce DX project for tracking water usage, leaks, and recycling across facilities.

## Structure
- `codebase/` - Contains the complete Salesforce DX project
- `docs/` - Documentation (coming soon)

## Quick Start
See `codebase/README.md` for deployment instructions.

## Project Features
- Custom objects: Facility, Building, Unit, Water Usage, Recycling Log, Leak Report
- Apex classes for rollup calculations and dashboard services
- Lightning Web Component (waterDashboard) for metrics visualization
- Permission sets for different user roles
- Automated triggers for data rollups

## Dashboard Metrics
- Last 30-day water usage and recycling totals
- Conservation score (recycled/usage percentage)
- Open leak count
- Facility, building, and unit inventory counts