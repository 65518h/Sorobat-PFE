TableExtension 50166 "Transfer LineEXT" extends "Transfer Line"
{
    fields
    {

        /*GL2024    modify("Quantity Shipped")
            {
                Editable = true;
            }
            modify("Quantity Received")
            {
                Editable = true;
            }
            modify("Outstanding Qty. (Base)")
            {
                Editable = true;
            }
            modify("Qty. Shipped (Base)")
            {
                Editable = true;
            }
            modify("Qty. Received (Base)")
            {
                Editable = true;
            }
            modify("Qty. per Unit of Measure")
            {
                Editable = true;
            }

            modify("Outstanding Quantity")
            {
                Editable = true;
            }*/


        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                // >> HJ DSFT 12 03 2010
                CALCFIELDS(Stock);
                // << HJ DSFT 12 03 2010  
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                // >> HJ SORO 11-10-2016
                // CALCFIELDS(Stock);
                //  IF Quantity > Stock THEN ERROR(Text005, Stock);
                // >> HJ SORO 11-10-2016
            end;
        }

        field(50001; Stock; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Location Code" = field("Transfer-from Code")));
            Description = 'HJ @ DSFT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; Machine; Code[20])
        {
            Description = 'HJ @ DSFT';
            TableRelation = Véhicule;
        }
        /* field(50003; "N° Materiel"; Code[20])
         {
             Description = 'RB SORO 10/06/2015';
             TableRelation = Véhicule;

             trigger OnValidate()
             var
                 "// RB SOROU 17/04/15": Integer;
                 RecItem: Record Item;
                 RecItemJournalTemplate: Record "Item Journal Template";
                 RecItemLedgerEntry: Record "Item Ledger Entry";
                 RecGenProductPostingGroup: Record "Gen. Product Posting Group";
                 RecTree: Record Tree;
                 NotificationRotation: Record "Notification Reception";
                 RecUserSetup: Record "User Setup";
             begin
                 // RB SORO 17/04/2015
                 if RecItem.Get("Item No.") then;
                 if RecTree.Get(RecTree.Type::Item, RecItem."Tree Code") then;
                 if Format(RecTree."Frequence Rotation") <> '' then begin
                     RecItemLedgerEntry.SetCurrentkey("N° Véhicule", "Item No.", "Posting Date");
                     RecItemLedgerEntry.SetRange("N° Véhicule", "N° Materiel");
                     RecItemLedgerEntry.SetRange("Item No.", "Item No.");
                     if RecItemLedgerEntry.FindLast then begin
                         //MESSAGE('Dernier date comptabilisation est %1',RecItemLedgerEntry."Posting Date");
                         if CalcDate(RecTree."Frequence Rotation", RecItemLedgerEntry."Posting Date") > Today then
                             // MESSAGE('La prochaine date de changment de l article %1 pour le vehicule %2 est %3',
                             // "Item No.","N° Materiel",CALCDATE(RecGenProductPostingGroup."Frequence Rotation",RecItemLedgerEntry."Posting Date"));
                             Message(Text034, "Item No.", "N° Materiel", RecItemLedgerEntry."Posting Date");
                         RecUserSetup.SetRange("Notifier Rotation", true);
                         if RecUserSetup.FindFirst then
                             repeat
                                 NotificationRotation.Utilisateur := RecUserSetup."User ID";
                                 NotificationRotation."Type Notification" := NotificationRotation."type notification"::Rotation;
                                 //NotificationRotation."BL N °";
                                 NotificationRotation."Document N°" := "Document No.";
                                 NotificationRotation.Article := "Item No.";
                                 NotificationRotation.Description := Description;
                                 // Quantite Changement Demander
                                 NotificationRotation."Quantité Reçue" := Quantity;
                                 // Date Demande
                                 NotificationRotation."Date Reception" := Today;
                                 // Dernier Date Changement
                                 NotificationRotation."Date DA" := RecItemLedgerEntry."Posting Date";
                                 //NotificationRotation."Date Commande":= "Posting Date";
                                 // Demandeur
                                 NotificationRotation.Demandeur := UserId;
                                 // N° Materiel
                                 NotificationRotation."N° Materiel" := "N° Materiel";
                                 // Période d'utilisation
                                 NotificationRotation."Période d'utilisation" := Today - RecItemLedgerEntry."Posting Date";
                                 // Période Restante à Utiliser
                                 NotificationRotation."Période Restante à Utiliser" :=
                                 CalcDate(RecGenProductPostingGroup."Frequence Rotation", RecItemLedgerEntry."Posting Date") - Today;
                                 // Parametre Frequence de Rotation
                                 NotificationRotation."Parametre Frequence Rotation" := RecTree."Frequence Rotation";

                                 if not NotificationRotation.Insert then NotificationRotation.Modify;
                             until RecUserSetup.Next = 0;

                     end;
                 end;
                 // RB SORO 17/04/2015
             end;
         }*/
        field(50004; Affaire; Code[20])
        {
            Description = 'HJ SORO 13-06-2015';
        }
        field(50032; "Filtre Article"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';

            trigger OnValidate()
            begin
                // >> HJ DST 02-02-2013
                "Filtre Article" := Item.GetItemFilter("Filtre Article");
                Validate("Item No.", "Filtre Article");
                "Filtre Article" := '';
                // >> HJ DST 02-02-2013
            end;
        }
        field(51000; "Description Soroubat"; text[100])
        {

        }
        field(51001; "N° vehicule"; Code[20])
        {
            TableRelation = Véhicule;

        }
    }

    var
        Text034: label 'Attention !!! Dernier Date d''echangement de l''article %1 pour la véhicule %2 est %3';
        Item: Record Item;
        Text005: label 'You cannot ship more than %1 units.';
}

