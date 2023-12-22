// const BancoDescentralizado = artifacts.require('BancoDescentralizado');
// const chai = require('chai');
// const expect = chai.expect;

// contract('BancoDescentralizado', (accounts) => {
//     let bancoDescentralizadoInstance;

//     before(async () => {
//         // Configuración antes de todas las pruebas
//         bancoDescentralizadoInstance = await BancoDescentralizado.new({ from: accounts[0] });
//     });

//     describe('[1] Propietario del Contrato', () => {
//         it('[1.1] debería ser la cuenta que desplegó el contrato', async () => {
//             const propietario = await bancoDescentralizadoInstance.propietario();
//             expect(propietario).to.equal(accounts[0]);
//         });
//     });

//     describe('[2] Operaciones Bancarias', () => {
//         beforeEach(async () => {
//             // Configuración antes de cada prueba dentro de este bloque describe
//             // Puedes, por ejemplo, realizar depósitos iniciales para ciertas pruebas
//             await bancoDescentralizadoInstance.depositar({ value: web3.utils.toWei('1', 'ether'), from: accounts[1] });
//         });

//         it('[2.1] debería permitir depositar saldo correctamente', async () => {
//             const cantidadDepositada = web3.utils.toWei('1', 'ether');

//             await bancoDescentralizadoInstance.depositar({ value: cantidadDepositada, from: accounts[2] });

//             const saldoUsuario = await bancoDescentralizadoInstance.saldos(accounts[2]);

//             expect(saldoUsuario.toString()).to.equal(cantidadDepositada);
//         });

//         it('[2.2] debería permitir retirar saldo correctamente', async () => {
//             const cantidadRetirada = web3.utils.toWei('0.5', 'ether');

//             await bancoDescentralizadoInstance.retirar(cantidadRetirada, { from: accounts[1] });

//             const saldoUsuario = await bancoDescentralizadoInstance.saldos(accounts[1]);

//             expect(saldoUsuario.toString()).to.equal(web3.utils.toWei('1.5', 'ether'));
//         });

//         it('[2.3] no debería permitir al propietario retirar fondos de sus clientes', async () => {
//             const cantidadRetirada = web3.utils.toWei('0.5', 'ether');

//             // Utilizamos chai para manejar la excepción y verificar el mensaje de error
//             try {
//                 await bancoDescentralizadoInstance.retirar(cantidadRetirada, { from: accounts[0] });
//                 expect.fail('La transacción debería fallar');
//             } catch (error) {
//                 expect(error.message).to.include('No puedes retirar fondos de tus clientes');
//             }
//         });

//         it('[2.4] no debería permitir retirar más saldo del disponible', async () => {
//             const cantidadRetirada = web3.utils.toWei('5', 'ether');

//             // Utilizamos chai para manejar la excepción y verificar el mensaje de error
//             try {
//                 await bancoDescentralizadoInstance.retirar(cantidadRetirada, { from: accounts[1] });
//                 expect.fail('La transacción debería fallar');
//             } catch (error) {
//                 expect(error.message).to.include('Saldo insuficiente');
//             }
//         });

//         it('[2.5] debería permitir transferir saldo correctamente', async () => {
//             const cantidadTransferida = web3.utils.toWei('0.3', 'ether');

//             await bancoDescentralizadoInstance.transferir(accounts[2], cantidadTransferida, { from: accounts[1] });

//             const saldoReceptor = await bancoDescentralizadoInstance.saldos(accounts[2]);

//             expect(saldoReceptor.toString()).to.equal(cantidadTransferida);
//         });

//         it('[2.6] no debería permitir al propietario transferir fondos de sus clientes', async () => {
//             const cantidadTransferida = web3.utils.toWei('0.3', 'ether');

//             // Utilizamos chai para manejar la excepción y verificar el mensaje de error
//             try {
//                 await bancoDescentralizadoInstance.transferir(accounts[2], cantidadTransferida, { from: accounts[0] });
//                 expect.fail('La transacción debería fallar');
//             } catch (error) {
//                 expect(error.message).to.include('No puedes transferir fondos de tus clientes');
//             }
//         });

//         it('[2.7] no debería permitir transferir más saldo del disponible', async () => {
//             const cantidadTransferida = web3.utils.toWei('1', 'ether');

//             // Utilizamos chai para manejar la excepción y verificar el mensaje de error
//             try {
//                 await bancoDescentralizadoInstance.transferir(accounts[2], cantidadTransferida, { from: accounts[1] });
//                 expect.fail('La transacción debería fallar');
//             } catch (error) {
//                 expect(error.message).to.include('Saldo insuficiente');
//             }
//         });
//     });

//     after(async () => {
//         // Limpieza después de todas las pruebas
//         // Puedes realizar limpiezas globales aquí si es necesario
//     });
// });
