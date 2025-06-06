public class RewardsCalloutService{

    public static Integer submitUsersForRewardCallout(String jsonBody) {
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:IntegrationSB__BalancedLiving/rewards');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonBody);

        Http http = new Http();
        HttpResponse res;
        Integer statusCode;
        
        res = http.send(req);
        statusCode = res.getStatusCode();

        System.debug('Response Status: ' + statusCode);
        System.debug('Response Body: ' + res.getBody());

        return statusCode;

    }
}