public class AssignmentRuleRepo extends Repository {
	
    public AssignmentRuleRepo() {
        this.fields = 'Id, Name, SobjectType, Active';
        this.objectApiName = 'AssignmentRule';
    }
    
    public List<AssignmentRule> getAssignmentRuleByName(String nameAssignRule)
    {
        // Here is used the queryWithBinds
        return (List<AssignmentRule>) this.getRecordsByWhereUsingBinds(' Name = :nameAssignRule', new Map<String, Object>{
            'nameAssignRule' => nameAssignRule
        });
    }
}