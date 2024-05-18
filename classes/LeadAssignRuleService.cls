public class LeadAssignRuleService {
	
    public void assignSpecificRuleToLead( String assignRuleName, List<Lead> leads ) {
		
        Boolean assignRuleNameEmpty = String.isBlank( assignRuleName );
        Boolean leadsIsNull = leads == null;
        Boolean leadsIsEmpty = leads != null && leads.isEmpty();
        
        if ( assignRuleNameEmpty || leadsIsNull || leadsIsEmpty ) return;
        
        List<AssignmentRule> assignmentRules = this.instanceAssignmentRuleRepo.getAssignmentRuleByName( assignRuleName );
        
        if ( assignmentRules != null && !assignmentRules.isEmpty() ) {
			AssignmentRule assignmentRuleR = assignmentRules[0];
            
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.assignmentRuleId = assignmentRuleR.Id;
            
            for ( Lead leadR : leads ) {
                leadR.setOptions(dmo);
            }
            
            this.instanceLeadRepo.insertRecords( (List<SObject>) leads);
        }
        
    }
    
    // Attributes methods - Singletons
    public AssignmentRuleRepo instanceAssignmentRuleRepo {
        get {
            if (this.instanceAssignmentRuleRepo == null) this.instanceAssignmentRuleRepo = new AssignmentRuleRepo();
            return this.instanceAssignmentRuleRepo;
        }
        set;
    }
    
    public LeadRepo instanceLeadRepo {
        get {
            if (this.instanceLeadRepo == null) this.instanceLeadRepo = new LeadRepo();
            return this.instanceLeadRepo;
        }
        set;
    }
}