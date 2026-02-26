pageextension 50297 "Posted Invt. Shipment" extends "Posted Invt. Shipment"
{
    layout
    {
        addafter(Correction)
        {
            field("DYSJob No."; Rec."DYSJob No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("DYSJob Task No."; Rec."DYSJob Task No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("DYSJob Planning Line No."; Rec."DYSJob Planning Line No.") { ApplicationArea = all; Editable = false; }
            field("N° Materiel"; Rec."N° Materiel") { ApplicationArea = all; Editable = false; }
            field("Lieu Livraison / Provenance"; Rec."Lieu Livraison / Provenance") { ApplicationArea = all; Editable = false; }
            field(Receptioneur; Rec.Receptioneur) { ApplicationArea = all; Editable = false; }
            field("Index Vehicule"; Rec."Index Vehicule") { ApplicationArea = all; Style = StrongAccent; Editable = false; }
            field("N° Piéce"; Rec."N° Piéce") { ApplicationArea = all; Editable = false; Visible = false; }
            field(Observation; Rec.Observation) { ApplicationArea = all; Editable = false; }
            field(Benificiaire; Rec.Benificiaire) { ApplicationArea = all; Editable = false; }
            field("Date Saisie"; Rec."Date Saisie")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Utilisateur; Rec.Utilisateur)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        addfirst(navigation)
        {
            action("Imprimer A4")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                var
                    RepInvMVT: Report "Inventory Movement SpecA4";
                    InvtShipmentHeader2: Record "Invt. Shipment Header";
                begin
                    InvtShipmentHeader2.Reset();
                    InvtShipmentHeader2.SetRange("No.", Rec."No.");
                    // InvtShipmentHeader.SetRange("Document Type", InvtShipmentHeader."Document Type"::Shipment);
                    if InvtShipmentHeader2.FindFirst() then begin
                        RepInvMVT.SetTableView(InvtShipmentHeader2);
                        RepInvMVT.Run();
                    end;

                end;
            }
            action("Imprimer")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                var
                    RepInvMVT: Report "Inventory Movement Spec";
                    InvtShipmentHeader2: Record "Invt. Shipment Header";
                begin
                    InvtShipmentHeader2.Reset();
                    InvtShipmentHeader2.SetRange("No.", Rec."No.");
                    // InvtShipmentHeader.SetRange("Document Type", InvtShipmentHeader."Document Type"::Shipment);
                    if InvtShipmentHeader2.FindFirst() then begin
                        RepInvMVT.SetTableView(InvtShipmentHeader2);
                        RepInvMVT.Run();
                    end;

                end;
            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}