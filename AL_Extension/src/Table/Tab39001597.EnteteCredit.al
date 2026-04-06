// Table 39001597 "Entete Credit"
// {
//     //GL2024  ID dans Nav 2009 : "39001597"
//     DrillDownPageID = "Liste Credit";
//     LookupPageID = "Liste Credit";

//     fields
//     {
//         field(1; Banque; Option)
//         {
//             OptionMembers = " ",ATB,ATTIJARI,BNA,BH,BT,BTE,BTL,BTK,QNB,STB,IUB,UBCI,ZITOUNA,BIAT,STUCID;
//         }
//         field(50000; "Compte Bancaire"; Code[20])
//         {
//             TableRelation = "Bank Account";
//         }
//         field(50001; "Type Calcul"; Option)
//         {
//             OptionMembers = "Annuité Constante","Mensualité Constante","Trimestrailité Constante","Semestrialité Constante","Annuité Degressive","Mensualité Degressive","Trimestrailité Degressive","Semestrialité Degressive";
//         }
//         field(50002; "Date Credit"; Date)
//         {
//         }
//         field(50003; "Nombre Tranche"; Integer)
//         {
//         }
//         field(50004; TMM; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 "Taux Credit" := TMM + "Taux Interet";
//             end;
//         }
//         field(50005; "Taux Interet"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 "Taux Credit" := TMM + "Taux Interet";
//             end;
//         }
//         field(50006; "Taux Credit"; Decimal)
//         {
//             Editable = false;
//         }
//         field(50007; "Montant Credit"; Decimal)
//         {
//         }
//         field(50008; Observation; Text[200])
//         {
//         }
//         field(50009; "Numero Credit"; Code[20])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Numero Credit")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         LigneCredit.SetRange("Numero Credit", "Numero Credit");
//         LigneCredit.DeleteAll;
//     end;

//     trigger OnInsert()
//     begin
//         // GeneralLedgerSetup.Get;
//         // if "Numero Credit" = '' then begin
//         //     TestNoSeries;
//         //     NoSeriesMgt.InitSeries(GetNoSeriesCode, GeneralLedgerSetup."Souche Credit", Today,
//         //                            "Numero Credit", GeneralLedgerSetup."Souche Credit");
//         // end;
//     end;

//     var
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         RespCenter: Record "Responsibility Center";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         Text001: label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
//         Text002: label 'N° Fiche Deja Saise';
//         LigneCredit: Record "Ligne Credit";


//     procedure InitRecord()
//     var
//     //  lNoteOfExpensesIntegr: Codeunit "Note of Expenses integr.";
//     begin
//         // NoSeriesMgt.SetDefaultSeries("Numero Credit", GeneralLedgerSetup."Souche Credit");
//     end;


//     procedure AssistEdit(OldPurchHeader: Record "Purchase Header"): Boolean
//     begin
//     end;

//     local procedure TestNoSeries(): Boolean
//     var
//     // lSubscrSetup: Record 8001900;
//     begin
//         // GeneralLedgerSetup.TestField("Souche Credit");
//     end;

//     local procedure GetNoSeriesCode(): Code[10]
//     var
//     // lSubscrSetup: Record 8001900;
//     begin
//         //  exit(GeneralLedgerSetup."Souche Credit");
//     end;

//     local procedure GetPostingNoSeriesCode(): Code[10]
//     begin
//     end;

//     local procedure TestNoSeriesDate(No: Code[20]; NoSeriesCode: Code[10]; NoCapt: Text[1024]; NoSeriesCapt: Text[1024])
//     var
//         NoSeries: Record "No. Series";
//     begin
//         if (No <> '') and (NoSeriesCode <> '') then begin
//             NoSeries.Get(NoSeriesCode);
//             if NoSeries."Date Order" then
//                 Error(Text001);
//         end;
//     end;
// }

