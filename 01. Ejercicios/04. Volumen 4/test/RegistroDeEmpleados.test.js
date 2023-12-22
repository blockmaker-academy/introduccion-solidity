const RegistroDeEmpleados = artifacts.require('RegistroDeEmpleados');
const chai = require('chai');
const expect = chai.expect;

contract('RegistroDeEmpleados', (accounts) => {
    let registroDeEmpleadosInstance;

    before(async () => {
        // Configuración antes de todas las pruebas
        registroDeEmpleadosInstance = await RegistroDeEmpleados.new({ from: accounts[0] });
    });

    describe('[1] Propietario del Contrato', () => {
        it('[1.1] debería ser la cuenta que desplegó el contrato', async () => {
            const propietario = await registroDeEmpleadosInstance.propietario();
            expect(propietario).to.equal(accounts[0]);
        });
    });

    describe('[2] Operaciones con Empleados', () => {
        beforeEach(async () => {
            try {
                // Configuración antes de cada prueba dentro de este bloque describe
                // Puedes, por ejemplo, agregar un empleado de prueba para ciertas pruebas
                await registroDeEmpleadosInstance.agregarEmpleado(1, 'Empleado de Prueba', 50000, { from: accounts[0] });
            } catch (error) {
                // Manejar la excepción de revert sin hacer nada
            }
        });

        it('[2.1] debería agregar un empleado correctamente', async () => {
            const empleadoId = 2;
            const nombre = 'Juan';
            const salario = 50000;

            await registroDeEmpleadosInstance.agregarEmpleado(empleadoId, nombre, salario, { from: accounts[0] });

            const empleado = await registroDeEmpleadosInstance.obtenerEmpleado(empleadoId);

            expect(empleado[0].toNumber()).to.equal(empleadoId);
            expect(empleado[1]).to.equal(nombre);
            expect(empleado[2].toNumber()).to.equal(salario);
        });

        it('[2.2] no debería permitir agregar un empleado con una identificación existente', async () => {
            const empleadoId = 1; // Ya existe un empleado con ID 1 según la configuración
            const nombre = 'Ana';
            const salario = 60000;

            // Utilizamos chai para manejar la excepción y verificar el mensaje de error
            try {
                await registroDeEmpleadosInstance.agregarEmpleado(empleadoId, nombre, salario, { from: accounts[0] });
                expect.fail('La transacción debería fallar');
            } catch (error) {
                expect(error.message).to.include('Empleado con esta identificacion ya existe');
            }
        });

        it('[2.3] debería actualizar el salario de un empleado correctamente', async () => {
            const empleadoId = 1; // Ya existe un empleado con ID 1 según la configuración
            const nuevoSalario = 70000;

            // Utilizamos chai para manejar la excepción y verificar el mensaje de error
            try {
                await registroDeEmpleadosInstance.actualizarSalarioEmpleado(empleadoId, nuevoSalario, { from: accounts[0] });
            } catch (error) {
                expect.fail('La transacción debería ser exitosa');
            }

            const empleadoActualizado = await registroDeEmpleadosInstance.obtenerEmpleado(empleadoId);

            expect(empleadoActualizado[2].toNumber()).to.equal(nuevoSalario);
        });

        it('[2.4] debería eliminar un empleado correctamente', async () => {
            const empleadoId = 1; // Ya existe un empleado con ID 1 según la configuración

            // Utilizamos chai para manejar la excepción y verificar el mensaje de error
            try {
                await registroDeEmpleadosInstance.eliminarEmpleado(empleadoId, { from: accounts[0] });
            } catch (error) {
                expect.fail('La transacción debería ser exitosa');
            }

            // Intentamos obtener al empleado eliminado, debería fallar
            try {
                await registroDeEmpleadosInstance.obtenerEmpleado(empleadoId);
                expect.fail('La transacción debería fallar');
            } catch (error) {
                expect(error.message).to.include('Empleado con esta identificacion no existe');
            }
        });
    });
});
