<?php
/**
*@package pXP
*@file    SubirArchivo.php
*@author  RCM 
*@date    27/05/2013
*@description permites subir archivos a la tabla
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SubirArchivoOTSol=Ext.extend(Phx.frmInterfaz,{

    constructor:function(config)
    {   
        Phx.vista.SubirArchivoOTSol.superclass.constructor.call(this,config);
        this.init();    
        this.loadValoresIniciales();
    },
    
    loadValoresIniciales:function()
    {        
        Phx.vista.SubirArchivoOTSol.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_orden_trabajo_sol').setValue(this.id_orden_trabajo_sol);     
    },
    
    successSave:function(resp)
    {
        Phx.CP.loadingHide();
        Phx.CP.getPagina(this.idContenedorPadre).reload();
        this.panel.close();
    },
                
    
    Atributos:[
        {
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'id_orden_trabajo_sol'
            },
            type:'Field',
            form:true
        },
        {
            config:{
                fieldLabel: "Archivo",
                gwidth: 130,
                inputType:'file',
                name: 'archivo',
                buttonText: '', 
                maxLength:150,
                anchor:'100%'                   
            },
            type:'Field',
            form:true 
        },      
    ],
    title:'Subir Archivo',    
    fileUpload:true,
    ActSave:'../../sis_mantenimiento/control/OrdenTrabajoSol/subirArchivo'       
}
)    
</script>