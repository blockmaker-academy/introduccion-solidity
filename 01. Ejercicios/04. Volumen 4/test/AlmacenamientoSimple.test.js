// SimpleStorageTest.js
import fetch from "node-fetch";
const AlmacenamientoSimple = artifacts.require('AlmacenamientoSimple');
const { expect } = require('chai');

contract('AlmacenamientoSimple', (cuentas) => {
  let almacenamientoSimple;

  beforeEach(async () => {
    almacenamientoSimple = await AlmacenamientoSimple.new();
  });

  it('debería establecer y obtener datos', async () => {
    const nuevosDatos = 42;

    // Establecer datos
    await almacenamientoSimple.establecerDatos(nuevosDatos);

    // Obtener datos y afirmar
    const resultado = await almacenamientoSimple.obtenerDatos();
    expect(resultado.toNumber()).to.equal(nuevosDatos);
  });
});