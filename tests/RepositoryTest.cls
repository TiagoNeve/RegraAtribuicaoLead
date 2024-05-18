@isTest
private class RepositoryTest {
    @isTest
    static void itShouldGetRecordById() {
        // GIVEN
        Repository c = new Repository();
        c.fields = 'Id';
        c.objectApiName = 'User';

        // WHEN
        SObject recordUser = c.getRecordById(UserInfo.getUserId());

        // THEN
        System.assert(recordUser.Id != null, 'Deveria ter encontrado o usuário');
        System.assert(recordUser.Id == UserInfo.getUserId(), 'Os ids de usuários deveriam ser o mesmo');
    }

    @isTest
    static void itShouldGetRecordsByWhere() {
        // GIVEN
        Repository c = new Repository();
        c.fields = 'Id';
        c.objectApiName = 'User';

        // WHEN
        List<SObject> recordUsers = c.getRecordsByWhere('Id = \'' + UserInfo.getUserId() + '\'');

        // THEN
        System.assert(!recordUsers.isEmpty(), 'Deveria ter encontrado pelo menos 1 registro');
        System.assert(recordUsers[0].Id != null, 'Deveria ter encontrado o usuário');
        System.assert(recordUsers[0].Id == UserInfo.getUserId(), 'Os ids de usuários deveriam ser o mesmo');
    }

    @isTest
    static void itShouldGetRecordsByWhereUsingBinds() {
        // GIVEN
        Repository c = new Repository();
        c.fields = 'Id';
        c.objectApiName = 'User';

        // WHEN
        List<SObject> recordUsers = c.getRecordsByWhereUsingBinds('Id = :idRecord', new Map<String, Object> {
            'idRecord' => UserInfo.getUserId()
        });

        // THEN
        System.assert(!recordUsers.isEmpty(), 'Deveria ter encontrado pelo menos 1 registro');
        System.assert(recordUsers[0].Id != null, 'Deveria ter encontrado o usuário');
        System.assert(recordUsers[0].Id == UserInfo.getUserId(), 'Os ids de usuários deveriam ser o mesmo');
    }

    @isTest
    static void itShouldInsertRecord() {
        // GIVEN
        Repository c = new Repository();
        c.fields = 'Id';
        c.objectApiName = 'User';

        Lead l = new Lead(LastName='Test', Company='Test');

        // WHEN
        Test.startTest();
        System.SavePoint SP1 = Database.setSavepoint();

        Database.SaveResult resultInsert = c.insertRecord( (SObject) l);

        // THEN
        System.assert(resultInsert.isSuccess(), 'Deveria ter inserido o registro');

        Database.rollback(SP1);
        Test.stopTest();
    }

    @isTest
    static void itShouldNotInsertRecord() {
        // GIVEN
        Repository c = new Repository();
        c.fields = 'Id';
        c.objectApiName = 'User';

        Lead l = new Lead(Company='Test');

        // WHEN
        Test.startTest();
        System.SavePoint SP1 = Database.setSavepoint();

        Database.SaveResult resultInsert = c.insertRecord( (SObject) l);

        // THEN
        System.assert(!resultInsert.isSuccess(), 'Não Deveria ter inserido o registro');

        Database.rollback(SP1);
        Test.stopTest();
    }

    @isTest
    static void itShouldInsertRecords() {
        // GIVEN
        Repository c = new Repository();
        c.fields = 'Id';
        c.objectApiName = 'User';

        Lead l = new Lead(LastName='Test', Company='Test');

        // WHEN
        Test.startTest();
        System.SavePoint SP1 = Database.setSavepoint();

        List<Database.SaveResult> resultInserts = c.insertRecords(new List<SObject>{ (SObject) l});

        // THEN
        System.assert( !resultInserts.isEmpty() , 'A lista não deveria estar vazia');
        System.assert( resultInserts[0].isSuccess(), 'Deveria ter inserido o registro');

        Database.rollback(SP1);
        Test.stopTest();
    }
}