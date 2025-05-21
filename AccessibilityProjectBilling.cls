global class AccessibilityProjectBilling{
    
     @future(callout=true)
     public static void callBillingService(String projectId, Decimal billingAmount){
     
          BillingServiceProxy.InvoicesPortSoap11 stub = new BillingServiceProxy.InvoicesPortSoap11();

          //Setup username, password, billAmount, and projectid in BillingServiceProxy.project and then call billProject method
          BillingServiceProxy.project project = new BillingServiceProxy.project();
          project.projectid = projectId;
          project.billAmount = Double.valueOf(billingAmount);
          project.username = '{!$Credential.BillingServiceCredential.username}';
          project.password = '{!$Credential.BillingServiceCredential.password}';

          //If response is ok set Accessibility Project Status = Complete
          String response = stub.billProject(project);

          if(response == 'OK') {
               Accessibility_Project__c accProject = [
                    SELECT 
                         Id,
                         Status__c 
                    FROM 
                         Accessibility_Project__c 
                    WHERE 
                         Id = :projectId
               ];

               accProject.Status__c = 'Complete';

               update accProject;
          }
     }
}