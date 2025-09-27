# Water Conservation CRM (New)

A fresh Salesforce DX project scaffolded from scratch to track water usage, leaks, and recycling.

## Prerequisites
- Salesforce CLI (sf) installed

## Deploy to an existing org alias (example: watercrm)
- sf project deploy start -o watercrm --project-dir .

## Scratch Org (optional)
- sf org create scratch -f config/project-scratch-def.json -a water-crm-new -d 7
- sf project deploy start -o water-crm-new --project-dir .
- sf org assign permset -n Facility_Manager -o water-crm-new
- sf org open -o water-crm-new
