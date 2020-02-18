codeunit 50301 MyEventSubscriberCodeunit
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Subst.", 'OnCalcCustPriceOnBeforeCalcQtyAvail', '', true, true)]
    local procedure UpdateDocumentNo(VAR Item: Record Item; SalesLine: Record "Sales Line"; VAR TempItemSubstitution: Record "Item Substitution")
    var
    begin
        TempItemSubstitution.SetSalesOrderNo(SalesLine."Document No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]
    procedure MyProcedure(VAR SalesHeader: Record "Sales Header"; VAR HideDialog: Boolean; VAR IsHandled: Boolean; VAR DefaultOption: Integer; VAR PostAndSend: Boolean)
    begin
        IF ((SalesHeader."Posting Date" = TODAY) OR (SalesHeader."Document Date" = TODAY)) THEN
            EXIT;
        IF DIALOG.CONFIRM(Confirmation, TRUE) THEN BEGIN
            SalesHeader.Validate("Posting Date", Today);
            SalesHeader.Validate("Document Date", Today);
            SalesHeader.MODIFY;
        END;
        DIALOG.MESSAGE(Text001);
    END;



    var
        Confirmation: Label 'Do you want to update the Posting Date to Today ?';
        Text001: Label 'Updated Successfully';
}