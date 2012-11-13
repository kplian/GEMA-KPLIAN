<?php
/**
*@package pXP
*@file 	  SubirDocumento.php
*@author  Gonzalo Sarmiento 
*@date 	  24-10-2012
*@description permites subir archivos a la tabla de documento
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SubirDocumento=Ext.extend(Phx.frmInterfaz,{

	constructor:function(config)
	{	
		
    	//llama al constructor de la clase padre
		Phx.vista.SubirDocumento.superclass.constructor.call(this,config);
		this.init();	
		this.loadValoresIniciales();
	},
	
	loadValoresIniciales:function()
	{
		
		Phx.vista.SubirDocumento.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_documento').setValue(this.id_documento);		
	},
	
	successSave:function(resp){
        Phx.CP.loadingHide();
        Phx.CP.getPagina(this.idContenedorPadre).reload();
        this.panel.close();
    },
				
	
	Atributos:[
	    {
   	      config:{
			labelSeparator:'',
			inputType:'hidden',
			name: 'id_documento'

		   },
		  type:'Field',
		  form:true 
		
	    },
		{
			//configuracion del componente
			config:{
					fieldLabel: "Archivo",
					gwidth: 130,
					//labelSeparator:'',
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
	title:'Subir documento',
	fileUpload:true,
	
	guardar: function(o){
	    // arma json en cadena para enviar al servidor
	    Ext.apply(this.argumentSave, o.argument);

            //console.log(this.argumentSave,o.argument)
            if (this.fileUpload) {

                Ext.Ajax.request({
                    form: this.form.getForm().getEl(),
                    url: this.ActSave,
                    params: this.getValForm,
                    isUpload: this.fileUpload,
                    success: this.successSaveFileUpload,
                    argument: this.argumentSave,
                    failure: function(r) {
                        console.log('falla upload', r)
                        },
                    timeout: this.timeout,
                    scope: this
                })

                } else {
                Ext.Ajax.request({
                    url: this.ActSave,
                    //params:this.form.getForm().getValues(),
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
                this.ActSave='../../sis_mantenimiento/control/Documento/subirDocumento';
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
            this.ActSave='../../sis_mantenimiento/control/Documento/subirVersionDocumento';
            this.guardar(this);        
        }else{
            this.ActSave='../../sis_mantenimiento/control/Documento/subirDocumento';
            this.guardar(this);   
        }        
    }    	
	}
)
	
</script>