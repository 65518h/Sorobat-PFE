PageExtension 50126 "Purchases Payables Set_PagEXT" extends "Purchases & Payables Setup"
{

    layout
    {

        modify("Check Prepmt. when Posting")
        {
            trigger OnAfterValidate()
            begin
                //#8609
                //GL2024  ArchivingMethodENABLED := rec."Archive Quotes and Orders";
                //#8609//
            end;
        }

        addafter("Default Qty. to Receive")
        {
            field("Archive Orders2"; Rec."Archive Orders")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Vendor Shipment No. Mandatory"; Rec."Vendor Shipment No. Mandatory")
            {
                ApplicationArea = all;
            }
            field("Archiving Method"; Rec."Archiving Method")
            {
                //GL2024    Enabled = ArchivingMethodENABLED;
                ApplicationArea = all;
            }
            field("Groupe Compta Marche TVA"; Rec."Groupe Compta Marche TVA")
            {
                ApplicationArea = all;

            }
            field("Autoriser Approbation DA"; Rec."Autoriser Approbation DA")
            {
                ApplicationArea = all;
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("Note of Expenses Nos."; Rec."Note of Expenses Nos.")
            {
                ApplicationArea = all;
            }
            field("Posted Note of Expenses Nos."; Rec."Posted Note of Expenses Nos.")
            {
                ApplicationArea = all;
            }
            field("Transit File Nos."; Rec."Transit File Nos.")
            {
                ApplicationArea = all;
            }
            field("Dechargement Srv Comptable"; Rec."Dechargement Srv Comptable")
            {
                ApplicationArea = all;
            }
            field("Dechargement Srv Controle"; Rec."Dechargement Srv Controle")
            {
                ApplicationArea = all;
            }
            field("Dechargement Srv Finance"; Rec."Dechargement Srv Finance")
            {
                ApplicationArea = all;
            }
            field("Dechargement Avoir Srv Compta"; Rec."Dechargement Avoir Srv Compta")
            {
                ApplicationArea = all;
            }
            field("Activer Controle Marché"; Rec."Activer Controle Marché")
            {
                ApplicationArea = all;
            }
        }


        addafter("Posted Credit Memo Nos.")
        {
            field("Purchase Request Nos."; Rec."Purchase Request Nos.") { ApplicationArea = all; }
        }
        addafter("Allow Document Deletion Before")
        {
            field("Lien Externe"; Rec."Lien Externe") { ApplicationArea = all; }
            field("Lien Interne"; Rec."Lien Interne") { ApplicationArea = all; }
            field("envoyer Mail DA"; Rec."Envoyer Mail DA") { ApplicationArea = all; }
            field("management controlleractivated"; Rec."management controlleractivated") { ApplicationArea = all; }
            field("management controller 1"; Rec."management controller 1") { Caption = 'CC DA Email'; ApplicationArea = all; }
            field("management controller 2"; Rec."management controller 2") { ApplicationArea = all; }
            field("Durée Suppression Fichier"; Rec."Durée Suppression Fichier")
            {
                ApplicationArea = all;
            }



        }

    }


    actions
    {

    }

    trigger OnOpenPage()
    begin
        //#8609
        //GL2024    ArchivingMethodENABLED := rec."Archive Quotes and Orders";
        //#8609//
    end;

    var
        ArchivingMethodENABLED: Boolean;
}

