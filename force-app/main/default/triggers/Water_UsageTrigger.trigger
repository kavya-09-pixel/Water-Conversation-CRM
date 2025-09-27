trigger Water_UsageTrigger on Water_Usage__c (after insert, after update, after delete, after undelete) {
    Set<Id> facilityIds = new Set<Id>();
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Water_Usage__c r : Trigger.new) {
            if (r.Facility__c != null) facilityIds.add(r.Facility__c);
        }
    }
    if (Trigger.isDelete) {
        for (Water_Usage__c r : Trigger.old) {
            if (r.Facility__c != null) facilityIds.add(r.Facility__c);
        }
    }
    if (!facilityIds.isEmpty()) {
        WaterConservationRollup.recalcForFacilities(facilityIds);
    }
}
