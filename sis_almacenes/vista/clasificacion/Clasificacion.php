<?php
/**
 * @package pxP
 * @file    Clasificacion.php
 * @author  Gonzalo Sarmiento
 * @date    21-09-2012
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Clasificacion=Ext.extend(Phx.arbInterfaz,{
        constructor:function(config){
            this.maestro=config.maestro;
            //llama al constructor de la clase padre
            Phx.vista.Clasificacion.superclass.constructor.call(this,config);
            
            this.init();
            
            //de inicio bloqueamos el botono nuevo
            //this.tbar.items.get('b-new-'+this.idContenedor).disable()
            //this.init();
            //this.loaderTree.baseParams={id_subsistema:this.id_subsistema};
            //this.load({params:{start:0, limit:50}})
        },
                    
    Atributos:[
        {
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_clasificacion'
            },
            type:'Field',
            form:true 
        },
        {
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'id_clasificacion_fk'
                
            },
            type:'Field',
            form:true
        },
        {
            config:{
                name: 'codigo',
                fieldLabel: 'Codigo',
                allowBlank: false,
                anchor: '80%',
                maxLength:4
            },
            type:'TextField',           
            filters:{pfiltro:'cla.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre',
                fieldLabel: 'Nombre',
                allowBlank: false,
                anchor: '80%',
                gwidth: 100,
                maxLength:25
            },
            type:'TextField',
            filters:{pfiltro:'cla.nombre',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'descripcion',
                fieldLabel: 'Descripcion',
                allowBlank: true,
                anchor: '80%',
                gwidth: 100,
                maxLength:100
            },
            type:'TextField',
            filters:{pfiltro:'cla.descripcion',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },          
    ],
    title:'Clasificacion',
    ActSave:'../../sis_almacenes/control/Clasificacion/insertarClasificacion',
    ActDel:'../../sis_almacenes/control/Clasificacion/eliminarClasificacion',
    ActList:'../../sis_almacenes/control/Clasificacion/listarClasificacionArb',
    id_store:'id_clasificacion',
    textRoot:'EQUIPOS',
    id_nodo:'id_clasificacion',
    id_nodo_p:'id_clasificacion_fk',
    
    onButtonNew:function(){
            var nodo = this.sm.getSelectedNode();           
            Phx.vista.Clasificacion.superclass.onButtonNew.call(this);
            
        
            //Phx.CP.getPagina(this.idContenedor+'-east').setMarkerDragableOn();
            
        //this.getComponente('nivel').setValue((nodo.attributes.nivel*1)+1);
     },    
    
    fields: [
        'id',
        'tipo_meta',
        {name:'id_clasificacion', type: 'numeric'},
        {name:'id_clasificacion_fk', type: 'numeric'},
        {name:'codigo', type: 'string'},
        {name:'nombre', type: 'string'},
        {name:'descripcion', type: 'string'}        
    ],
    
    sortInfo:{
        field: 'id_clasificacion',
        direction: 'ASC'
    },
    bdel:true,
    bsave:true,
    bexcel:true,
    rootVisible:true,
    //sobrecarga prepara menu
    
     preparaMenu:function(n){
            //si es una nodo tipo carpeta habilitamos la opcion de nuevo
                            
            if(n.attributes.tipo_nodo == 'hijo' || n.attributes.tipo_nodo == 'raiz' || n.attributes.id == 'id'){
                    this.tbar.items.get('b-new-'+this.idContenedor).enable()
                }
                else {
                    this.tbar.items.get('b-new-'+this.idContenedor).disable()
                }
            
        
            // llamada funcion clace padre
            Phx.vista.Clasificacion.superclass.preparaMenu.call(this,n);
        },
        
    EnableSelect:function(n){
        var nivel = n.getDepth();
        var direc = this.getNombrePadre(n)
        if(direc){
            //Phx.CP.getPagina(this.idContenedor+'-east').ubicarPos(direc,nivel)
            Phx.vista.Clasificacion.superclass.EnableSelect.call(this,n)
        }
        
    },
    
    getNombrePadre:function(n){
        var direc 
        
        
        var padre = n.parentNode;
        
        
        if(padre){
            if(padre.attributes.id!='id'){
               direc = n.attributes.nombre +' - '+ this.getNombrePadre(padre)
               return direc;
            }else{
                
                return n.attributes.nombre;
            }
        }
        else{
                return undefined;
        }       
     }

}
)
</script>       
        