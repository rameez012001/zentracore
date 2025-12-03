namespace zentracore.srv;

using { zentracore.db as db } from '../db/schema';
// using { API_BUSINESS_PARTNER as a } from './external/API_BUSINESS_PARTNER';

service MyService @(require : 'authenticated-user'){

    entity Person as projection on db.Person;
    entity Passport as projection on db.Passport;
    action doSomething() returns Boolean;
    
    // entity Business as projection on a.A_Customer{
    //     key Customer,
    //     CustomerName,
    //     CustomerFullName
    // };

    // entity BusinessStore as projection on db.BusinessStore;


    // action assignDL() returns String;

    action postAge(id: Int32, age: Int16) returns Person;
    function getAppropriateAge(id:Int32) returns  Person;
}
