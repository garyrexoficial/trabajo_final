// Módulo para gestionar las materias de un alumno en el sistema.
// Permite crear, agregar, eliminar y consultar materias de manera segura y eficiente.

module trabajo_final::materias_de_sistemas {

    use std::string;

    /// Estructura principal que almacena el registro de materias de un alumno.
    public struct MateriasDeSistemas has key, store {
        id: UID,
        items: vector<string::String>,
    }

    /// Códigos de error
    const NOMBRE_DE_MATERIA_VACIO: u64 = 10;
    const INDICE_FUERA_DE_RANGO: u64 = 11;

    /// Crea un nuevo registro de materias para el alumno que llama la función.
     #[allow(lint(self_transfer))]
    public fun new(ctx: &mut TxContext) {
        let materias = MateriasDeSistemas {
            id: object::new(ctx),
            items: vector::empty<string::String>(),
        };
        transfer::transfer(materias, tx_context::sender(ctx));
    }

    /// Agrega una nueva materia al registro.
    /// Falla si el nombre está vacío.
    public fun alta(materias: &mut MateriasDeSistemas, item: string::String) {
        assert!(string::length(&item) > 0, NOMBRE_DE_MATERIA_VACIO);
        materias.items.push_back(item);
    }

    /// Elimina una materia por índice.
    /// Falla si el índice está fuera de rango.
    public fun baja(materias: &mut MateriasDeSistemas, index: u64) {
        assert!(index < vector::length(&materias.items), INDICE_FUERA_DE_RANGO);
        materias.items.remove(index);
    }

    /// Elimina el registro completo de materias (baja total).
    public fun baja_sistemas(materias: MateriasDeSistemas) {
        let MateriasDeSistemas { id, items: _ } = materias;
        object::delete(id);
    }

    /// Devuelve la cantidad de materias que cursa el alumno.
    public fun cantidad(materias: &MateriasDeSistemas): u64 {
        vector::length(&materias.items)
    }

    /// Consulta una materia por índice.
    /// Falla si el índice está fuera de rango.
    public fun consultar(materias: &MateriasDeSistemas, index: u64): &string::String {
        assert!(index < vector::length(&materias.items), INDICE_FUERA_DE_RANGO);
        vector::borrow(&materias.items, index)
    }

    /// Devuelve todas las materias (solo lectura).
    public fun listar(materias: &MateriasDeSistemas): &vector<string::String> {
        &materias.items
    }
}