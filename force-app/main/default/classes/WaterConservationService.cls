public with sharing class WaterConservationService {
    public class DashboardStats {
        @AuraEnabled public Decimal totalUsage;
        @AuraEnabled public Decimal totalRecycled;
        @AuraEnabled public Decimal conservationScore;
        @AuraEnabled public Integer openLeaks;
    }

    @AuraEnabled(cacheable=true)
    public static DashboardStats getOrgStats() {
        Date startDate = Date.today().addDays(-30);
        DashboardStats d = new DashboardStats();

        AggregateResult au = [SELECT SUM(Volume_Liters__c) total FROM Water_Usage__c WHERE Usage_Date__c >= :startDate];
        AggregateResult ar = [SELECT SUM(Recycled_Liters__c) total FROM Recycling_Log__c WHERE Log_Date__c >= :startDate];
        Integer leaks = (Integer)[SELECT COUNT() FROM Leak_Report__c WHERE Status__c IN ('New','Assigned','In Progress')];

        d.totalUsage = (Decimal)au.get('total');
        d.totalRecycled = (Decimal)ar.get('total');
        d.conservationScore = (d.totalUsage != null && d.totalUsage > 0 && d.totalRecycled != null)
            ? (d.totalRecycled / d.totalUsage) * 100 : null;
        d.openLeaks = leaks;
        return d;
    }
}
