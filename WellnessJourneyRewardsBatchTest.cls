@isTest
public with sharing class WellnessJourneyRewardsBatchTest {

    @TestSetup
    static void makeData(){
        User user1 = new User(
            FirstName = 'FirstName1',
            LastName = 'LastName1',
            Email = 'user1@email.com',
            Username = 'fn' + '.' + 'ln' + '@email.com',
            Alias = 'u1',
            TimeZoneSidKey = 'GMT',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LocaleSidKey = 'en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id
        );

        insert user1;

        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();

        for (Integer i = 0; i < 12; i++) {
            Wellness_Journey__c journey = new Wellness_Journey__c(
                Name = 'Journey' + i,
                OwnerId = user1.Id,
                Status__c = 'Complete',
                Completion_Date__c = Date.today().addMonths(-3)
            );

            journeys.add(journey);
        }

        insert journeys;
    }

    @isTest
    static void testBatch() {
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

        Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        Integer journeyCount = [SELECT Count() FROM Wellness_Journey__c];

        System.assertEquals(12, journeyCount);

    }
}