//HS
xmlport 50018 "Recuper Carriere V2"
{
    // Format = VariableText;
    // FieldSeparator = ';';
    // RecordSeparator = '<NewLine>';
    // TableSeparator = '<NewLine><NewLine>';
    // DefaultFieldsValidation = false;
    // schema
    // {
    //     textelement(NodeName1)
    //     {
    //         tableelement("BLCarriere"; "BL Carriere")
    //         {
    //             SourceTableView = SORTING("N° Societe", "N° Sequence", Annee, ID);
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;
    //             MinOccurs = Zero;

    //             fieldattribute("NSociete"; BLCarriere."N° Societe")
    //             {

    //             }
    //             fieldattribute("NSequence"; BLCarriere."N° Sequence")
    //             {

    //             }
    //             fieldattribute("Date"; BLCarriere.date)
    //             {

    //             }
    //             fieldattribute("CodeClient"; BLCarriere."Code Client")
    //             {

    //             }
    //             fieldattribute("CodeProduit"; BLCarriere."Code Produit")
    //             {

    //             }
    //             fieldattribute("Destination"; BLCarriere.Destination)
    //             {

    //             }
    //             fieldattribute("MoyendeTransport"; BLCarriere."Moyen de Transport")
    //             {

    //             }
    //             fieldattribute("Quantité"; BLCarriere.Quantité)
    //             {
    //                 trigger OnAfterAssignField()
    //                 begin
    //                     BLCarriere.VALIDATE(BLCarriere.Quantité);

    //                 end;
    //             }
    //             trigger OnAfterGetRecord()
    //             var
    //             begin
    //             end;
    //         }
    //         tableelement(ClientCarriere; "Client Carriere")
    //         {
    //             SourceTableView = SORTING("N° Societe", "Code Client");
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;
    //             MinOccurs = Zero;

    //             fieldattribute(NSocieteClientCarriere; ClientCarriere."N° Societe")
    //             {

    //             }
    //             fieldattribute(CodeClientCarriere; ClientCarriere."Code Client")
    //             {

    //             }
    //             fieldattribute(DesignationClientCarriere; ClientCarriere."Designation Client")
    //             {

    //             }
    //         }
    //         tableelement(ProduitCarriere; "Produit Carriere")
    //         {
    //             SourceTableView = SORTING("N° Societe", "Code produit");
    //             AutoSave = TRUE;
    //             AutoUpdate = TRUE;
    //             MinOccurs = Zero;

    //             fieldattribute(NSocieteProduitCarriere; ProduitCarriere."N° Societe")
    //             {

    //             }
    //             fieldattribute(CodeprduitCarriere; ProduitCarriere."Code produit")
    //             {

    //             }

    //             fieldattribute(DesignationProduitCarriere; ProduitCarriere."Designation Produit")
    //             {

    //             }
    //         }

    //     }
    // }

    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(GroupName)
    //             {
    //                 // field(Name; SourceExpression)
    //                 // {

    //                 // }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {

    //             }
    //         }
    //     }
    // }
    // trigger OnPostXmlPort()
    // begin
    //     COMMIT;
    // end;

    // var
    //     myInt: Integer;
}