namespace zentracore.db;
using {cuid  } from '@sap/cds/common';

entity Person {
    key id: Int32;
    name: String;
    age: Int16;
}

entity Passport {
    key id : Int32;
    document_no : Int16;
    person: Association to Person;
}

// entity BusinessStore : cuid{
//     CustomerName: String;
//     CustomerFullName: String;
// }