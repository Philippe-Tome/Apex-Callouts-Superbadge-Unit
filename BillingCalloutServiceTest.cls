@isTest
private with sharing class BillingCalloutServiceTest {

    @TestSetup
    static void makeData(){
        Accessibility_Project__c project1 = new Accessibility_Project__c(
            Amount__c = 5,
            Status__c = 'Submitted',
            Type__c = 'Accessibility Training'
        );
        
        insert project1;
    }

    @isTest
    static void testCallBillingService(){
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        Accessibility_Project__c project1 = [
            SELECT Id, Status__c, Amount__c 
            FROM Accessibility_Project__c 
            WHERE Status__c = 'Submitted' 
                AND Type__c = 'Accessibility Training' 
            LIMIT 1
        ];

        Test.startTest();
        AccessibilityProjectBilling.callBillingService(project1.Id, project1.Amount__c);
        Test.stopTest();

        Accessibility_Project__c projectAfterCall = [
            SELECT Id, Status__c 
            FROM Accessibility_Project__c 
            WHERE Id = :project1.Id
        ];
        
        System.Assert.areEqual('Complete', projectAfterCall.Status__c);

    }
}