// page 50091 "Liste Commande Ouverte"
// {
//     PageType = List;
//     SourceTable = "Purchase Line";
//     SourceTableView = SORTING("Document Type", "Buy-from Vendor No.") WHERE("Outstanding Quantity" = FILTER(<> 0), Type = CONST(Item), "Document Type" = CONST(Order));
//     Caption = 'Liste Commande Ouverte';
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             field(Fournisseur; Fournisseur)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Fournisseur';
//                 TableRelation = Vendor;

//                 trigger OnValidate()
//                 begin
//                     IF UserSetup.GET(UPPERCASE(USERID)) THEN;
//                     //RESET;
//                     rec.SETRANGE("Buy-from Vendor No.", Fournisseur);
//                     IF UserSetup."Filtre Magasin" <> '' THEN rec.SETRANGE("Location Code", UserSetup."Filtre Magasin");
//                     IF Fournisseur = '' THEN BEGIN
//                         rec.SETRANGE("Buy-from Vendor No.");
//                         rec.SETRANGE("Location Code");
//                     END;
//                     FournisseurOnAfterValidate;
//                 end;
//             }
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("Order Date"; rec."Order Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Quantity; rec.Quantity)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quantity Received"; rec."Quantity Received")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Outstanding Quantity"; rec."Outstanding Quantity")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             //DYS group(Fonction)
//             // {
//             //     Caption = 'Function';
//             //     action("Reception Achat")
//             //     {
//             //         ApplicationArea = all;
//             //         Caption = 'Purchase Receipt';
//             //         //DYS page addon non migrer
//             //         // RunObject = Page 8003949;
//             //         // RunPageLink = "No." = FIELD("Document No."), "Document Type" = FIELD("Document Type");
//             //         ShortCutKey = 'F9';
//             //     }
//             // }
//         }
//     }

//     var
//         Fournisseur: Code[20];
//         UserSetup: Record "User Setup";

//     local procedure FournisseurOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;
// }

