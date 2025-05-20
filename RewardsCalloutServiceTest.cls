@isTest
public with sharing class RewardsCalloutServiceTest {

    @isTest
    static void testCallout() {
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());

        List<Wellness_Journey__c> journeys = new List<Wellness_Journey__c>();
        Id myUserId = UserInfo.getUserId();

        for (Integer i; i < 12; i++) {
            Wellness_Journey__c journey = new Wellness_Journey__c(
                OwnerId = myUserId
            );

            journeys.add(journey);
        }

        insert journeys;

        Test.startTest();
        Database.executeBatch(new WellnessJourneyRewardsBatch());
        Test.stopTest();

        Integer statusCode = RewardsCalloutService.submitUsersForRewardCallout(JSON.serialize(journeys));

        System.assertEquals(200, statusCode);
    }

}