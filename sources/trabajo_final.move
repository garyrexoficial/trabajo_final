module trabajo_final::materias_de_sistemas {

    use std::string::String;
    
    public struct MateriasDeSistemas has key, store {
        id: UID,
        items: vector<String>,
    }

    
    public fun new(ctx: &mut TxContext) {
        let materias = MateriasDeSistemas {
            id: object::new(ctx),
            items: vector[],
        };

        transfer::transfer(materias, tx_context::sender(ctx));

    }
    
    // Añadir materia
    public fun alta(materias: &mut MateriasDeSistemas, item: String) {
        materias.items.push_back(item);
    }

    // Eliminar materia
    public fun baja(materias: &mut MateriasDeSistemas, index: u64) {
        materias.items.remove(index);
    }

    // Darse de baja de Sistemas
    public fun bajaSistemas(materias: MateriasDeSistemas) {
        let MateriasDeSistemas {id, items: _} = materias;
        object::delete(id);
    }

    // Numero de materias que se cursan
    public fun length(materias:&MateriasDeSistemas): u64 {
        materias.items.length()
    }

}