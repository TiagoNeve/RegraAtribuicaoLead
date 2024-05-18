@isTest
private class LeadAssignRuleServiceTest {
    @isTest
    static void itShouldAssignSpecificRuleToLead() {
        // GIVEN
        LeadAssignRuleService c = new LeadAssignRuleService();
        c.instanceAssignmentRuleRepo = (AssignmentRuleRepo) Test.createStub(AssignmentRuleRepo.class, new AssignmentRuleRepoMock() );
        c.instanceLeadRepo = (LeadRepo) Test.createStub(LeadRepo.class, new LeadRepoMock() );
        Lead l = new Lead(LastName = 'Test', Company = 'Test');

        // WHEN
        c.assignSpecificRuleToLead('Test', new List<Lead>{l});

        // THEN
    }

    // MOCKS
    private class AssignmentRuleRepoMock implements System.StubProvider {
        public Object handleMethodCall(
            Object stubbedObject
            , String stubbedMethodName
            , System.Type returnType
            , List<System.Type> listOfParamTypes
            , List<String> listOfParamNames
            , List<Object> listOfArgs) {
            
            Object returnValue;

            System.debug('stubbedObject');
            System.debug(stubbedObject);
            System.debug('stubbedMethodName');
            System.debug(stubbedMethodName);
            System.debug('returnType');
            System.debug(returnType);
            System.debug('listOfParamTypes');
            System.debug(listOfParamTypes);
            System.debug('listOfParamNames');
            System.debug(listOfParamNames);
            System.debug('listOfArgs');
            System.debug(listOfArgs);

            switch on stubbedMethodName {
                when 'getAssignmentRuleByName' {
                    AssignmentRule assignmentRuleR = (AssignmentRule) Schema.getGlobalDescribe().get('AssignmentRule').newSObject();
                    returnValue = new List<AssignmentRule>{
                        assignmentRuleR
                    };
                }
            }

            return returnValue;
        }
    }

    private class LeadRepoMock implements System.StubProvider {
        public Object handleMethodCall(
            Object stubbedObject
            , String stubbedMethodName
            , System.Type returnType
            , List<System.Type> listOfParamTypes
            , List<String> listOfParamNames
            , List<Object> listOfArgs) {
            
            Object returnValue;

            switch on stubbedMethodName {
                when 'insertRecords' {
                    
                }
            }

            return returnValue;
        }
    }
}