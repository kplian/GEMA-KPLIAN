<?php
/**
*@package pXP
*@file    SubirArchivo.php
*@author  Gonzalo Sarmiento 
*@date    24-10-2012
*@description permites subir archivos a la tabla de uni_cons_archivo
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SubirArchivo=Ext.extend(Phx.frmInterfaz,{

    constructor:function(config)
    {   
        Phx.vista.SubirArchivo.superclass.constructor.call(this,config);
        this.init();    
        this.loadValoresIniciales();
    },
    
    loadValoresIniciales:function()
    {        
        Phx.vista.SubirArchivo.superclass.loadValoresIniciales.call(this);
        this.getComponente('id_uni_cons_archivo').setValue(this.id_uni_cons_archivo);     
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
                name: 'id_uni_cons_archivo'
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
    
    guardar: function(o){
        // arma json en cadena para enviar al servidor
        Ext.apply(this.argumentSave, o.argument);
        if (this.fileUpload) {
            Ext.Ajax.request({
                form: this.form.getForm().getEl(),
                url: this.ActSave,
                params: this.getValForm,
                isUpload: this.fileUpload,
                success: this.successSaveFileUpload,
                argument: this.argumentSave,
                failure: function(r)
                {
                    console.log('falla upload', r)
                },
                timeout: this.timeout,
                scope: this
            });
        } else {
            Ext.Ajax.request({
            url: this.ActSave,
            params: this.getValForm,
            isUpload: this.fileUpload,
            success: this.successSave,
            argument: this.argumentSave,
            failure: this.conexionFailure,
            timeout: this.timeout,
            scope: this
            });
        }          
    },    
    
    onSubmit: function(o) {
        if (this.form.getForm().isValid()) {
            Phx.CP.loadingShow();            
            if(this.extension.length==0){
                this.ActSave='../../sis_mantenimiento/control/UniConsArchivo/subirArchivo';
                this.guardar(o);
            }else{
                Ext.MessageBox.buttonText.yes = "Versionar";
                Ext.MessageBox.buttonText.no = "Reemplazar";
                Ext.MessageBox.confirm('Confirm', 'Desea versionar o reemplazar?', this.choice,this);                
            }
        }
    },
    
    choice: function(btn){
        if(btn=='yes'){
            this.ActSave='../../sis_mantenimiento/control/UniConsArchivo/subirVersionArchivo';
            this.guardar(this);        
        }else{
            this.ActSave='../../sis_mantenimiento/control/UniConsArchivo/subirArchivo';
            this.guardar(this);   
        }        
    }       
}
)    
</script>