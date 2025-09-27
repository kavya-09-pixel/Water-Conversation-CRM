import { LightningElement, wire } from 'lwc';
import getOrgStats from '@salesforce/apex/WaterConservationService.getOrgStats';

export default class WaterDashboard extends LightningElement {
    totalUsage;
    totalRecycled;
    conservationScore;
    openLeaks;
    facilityCount;
    buildingCount;
    unitCount;

    @wire(getOrgStats)
    wiredStats({ data, error }) {
        if (data) {
            this.totalUsage = data.totalUsage || 0;
            this.totalRecycled = data.totalRecycled || 0;
            this.conservationScore = data.conservationScore != null ? Number(data.conservationScore).toFixed(2) : 0;
            this.openLeaks = data.openLeaks || 0;
            this.facilityCount = data.facilityCount || 0;
            this.buildingCount = data.buildingCount || 0;
            this.unitCount = data.unitCount || 0;
        } else if (error) {
            // eslint-disable-next-line no-console
            console.error(error);
        }
    }
}
