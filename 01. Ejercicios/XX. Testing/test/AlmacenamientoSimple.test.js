// SimpleStorageTest.js
const AlmacenamientoSimple = artifacts.require('AlmacenamientoSimple');
const { expect } = require('chai');

contract('AlmacenamientoSimple', (cuentas) => {
  let almacenamientoSimple;

  beforeEach(async () => {
    almacenamientoSimple = await AlmacenamientoSimple.new();
  });

  // Individual Test (it)
  it('Test [1]: Establecer y obtener datos', async () => {

    // Establecer datos
    await almacenamientoSimple.establecerDatos(42);

    // Obtener datos y afirmar
    const resultado = await almacenamientoSimple.obtenerDatos();
    expect(resultado.toNumber()).to.equal(42);
  });

});