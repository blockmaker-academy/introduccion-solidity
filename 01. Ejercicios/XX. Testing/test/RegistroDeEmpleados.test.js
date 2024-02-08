const RegistroDeEmpleados = artifacts.require('RegistroDeEmpleados');
const { expect } = require('chai');

contract('[1] RegistroDeEmpleados', (cuentas) => {
    let registroDeEmpleados;

    before(async () => {
        registroDeEmpleados = await RegistroDeEmpleados.new({from: cuentas[0]});
    });

    describe('[1.1] Pruebas Propietario Contrato', () => {

        it('[1.1.1] Debería ser la cuenta que desplegó el contrato', async () => {
            const propietario = await registroDeEmpleados.propietario();
            expect(propietario).to.equal(cuentas[0]);
        });

    });


});