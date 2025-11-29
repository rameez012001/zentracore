const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');
const { results } = require('@sap/cds/lib/utils/cds-utils');

module.exports = async function (srv) {
  const { Person } = srv.entities;
  srv.before("postAge", async (req) => {
    const { id } = req.data;
    const person = await SELECT.one.from(Person).where({ id });
    if (!person) req.error`id ${id} not found`
  })

  srv.on("postAge", async (req) => {
    const { id, age } = req.data;

    await UPDATE(Person)
      .set({ age: age })
      .where({ id: id });
    const person = await SELECT.from(Person).where({ id });
    return person[0];

  });

  srv.after("postAge", result => {
    result.value = "hello printed";
    return result;
  });

  srv.before("getAppropriateAge", async (req) => {
    const { id } = req.data;
    const person = await SELECT.from(Person).where({ id });
    if (person.age < 18) req.error`age is below`
    // return person;
  });

  srv.on("getAppropriateAge", async (req) => {
    const { id } = req.data;
    const person = await SELECT.from(Person).where({ id });
    return person;
  });

  // const s4bpa = await cds.connect.to('API_BUSINESS_PARTNER')

  // this.on('READ', 'Business', (req) => {

  //   return s4bpa.run(req.query)
  // })

  // srv.on("assignDL", async (req) => {
  //   const con = await cds.connect.to("API_BUSINESS_PARTNER");

  //   // instead of req.query
  //   const result = await con.run(
  //     SELECT.from("API_BUSINESS_PARTNER.A_Customer")
  //   );

  //   if (!result.length) return "NO objects found in external API";

  //   for (const row of result) {

  //     const temp = {
  //       CustomerFullName: row.CustomerFullName,
  //       CustomerName: row.CustomerName,
  //     };

  //     await INSERT.into("zcom.db.BusinessStore").entries(temp);
  //   }
  //   return "Data inserted successfully!";
  // });

};