public inherited sharing virtual class Repository {
	
    public String fields;
    public String objectApiName;
    
    // QUERIES
    public virtual SObject getRecordById(String idRecord)
    {
        return Database.query(
            'SELECT ' +
            fields + ' ' +
            'FROM ' + objectApiName +
            ' WHERE Id = \'' + idRecord + '\''
        );
    }
    
    public virtual List<SObject> getRecordsByWhere(String whereString)
    {
        return Database.query(
            'SELECT ' +
            fields + ' ' +
            'FROM ' + objectApiName +
            ' WHERE ' + whereString
        );
    }

    public virtual List<SObject> getRecordsByWhereUsingBinds(String whereString, Map<String, Object> binds)
    {
        return Database.queryWithBinds(
            'SELECT ' +
            fields + ' ' +
            'FROM ' + objectApiName +
            ' WHERE ' + whereString
            , binds
            , System.AccessLevel.USER_MODE
        );
    }
    
    // DML Operations
    public virtual Database.SaveResult insertRecord(SObject record) {
        Database.SaveResult result = Database.insert(record, false);
        
        // LOG execution DML.
        logDabaseSaveResult( new List<Database.SaveResult>{result}, new List<SObject>{record}, 'INSERT');
        
        return result;
    }
    
    public virtual List<Database.SaveResult> insertRecords(List<SObject> records) {
        List<Database.SaveResult> results = Database.insert(records, false);
        
        // LOG execution DML
        logDabaseSaveResult(results, records, 'INSERT');
        
        return results;
    }

    private void logDabaseSaveResult(List<Database.SaveResult> results, List<SObject> records, String modeOperation)
    {
        Integer aux = 0;
        for ( Database.SaveResult result : results ) {

            if ( result.isSuccess() ) {
                System.debug( modeOperation + ' successfuly');
                System.debug(' Id record: ' + result.getId());
            } else {
                for (Database.Error error : result.getErrors()) {
                    System.debug(LoggingLevel.ERROR, 'Record failed on ' + modeOperation);
                    System.debug(LoggingLevel.ERROR, 'Error Status Code: ' + error.getStatusCode());
                    System.debug(LoggingLevel.ERROR, 'Error Message: ' + error.getMessage());
                    System.debug(LoggingLevel.ERROR, 'Error Fields: ' + error.getFields());
                    System.debug(LoggingLevel.ERROR, 'JSON Record: ' + JSON.serialize(records[aux]));
                }
            }
            ++aux;
        }
    }
}