module.exports = async function (srv) {
    srv.on("doSomething", async (req) => {
        alert('hello');
        return true;
    
      });
}