@isTest
private class AssignmentRuleRepoTest {
    @isTest
    static void itShouldGetAssignmentRuleByName() {
        // GIVEN
        AssignmentRuleRepo c = new AssignmentRuleRepo();

        // WHEN
        Test.startTest();
        try {
            c.getAssignmentRuleByName('test');
        }
        catch ( Exception e ) {
            System.debug('Deu erro');
        }
        

        // THEN
        Test.stopTest();
    }
}