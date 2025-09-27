public with sharing class WaterConservationRollup {
    public static void recalcForFacilities(Set<Id> facilityIds) {
        if (facilityIds == null || facilityIds.isEmpty()) return;
        Date startDate = Date.today().addDays(-30);

        Map<Id, Decimal> usageByFacility = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT Facility__c f, SUM(Volume_Liters__c) total
            FROM Water_Usage__c
            WHERE Facility__c IN :facilityIds AND Usage_Date__c >= :startDate
            GROUP BY Facility__c
        ]) {
            usageByFacility.put((Id)ar.get('f'), (Decimal)ar.get('total'));
        }

        Map<Id, Decimal> recycledByFacility = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT Facility__c f, SUM(Recycled_Liters__c) total
            FROM Recycling_Log__c
            WHERE Facility__c IN :facilityIds AND Log_Date__c >= :startDate
            GROUP BY Facility__c
        ]) {
            recycledByFacility.put((Id)ar.get('f'), (Decimal)ar.get('total'));
        }

        List<Facility__c> updates = new List<Facility__c>();
        for (Id fid : facilityIds) {
            Decimal usage = usageByFacility.get(fid);
            Decimal recycled = recycledByFacility.get(fid);
            Facility__c f = new Facility__c(
                Id = fid,
                Last_Month_Usage__c = usage,
                Last_Month_Recycled__c = recycled,
                Conservation_Score__c = (usage != null && usage > 0 && recycled != null)
                    ? (recycled / usage) * 100
                    : null
            );
            updates.add(f);
        }
        if (!updates.isEmpty()) {
            update updates;
        }
    }
}
