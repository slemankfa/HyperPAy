package com.ass.hyperpay;

import io.flutter.embedding.android.FlutterActivity;
import android.content.ContextWrapper;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import java.util.LinkedHashSet;
import java.util.Set;
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings;
import com.oppwa.mobile.connect.provider.Connect;
import android.content.Intent;
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity;
import com.oppwa.mobile.connect.provider.Transaction;
import com.oppwa.mobile.connect.provider.TransactionType;
import com.oppwa.mobile.connect.exception.PaymentError;






public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.env.pay/payemntMethod";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
      new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
          .setMethodCallHandler(
            (call, result) -> {
              // Note: this method is invoked on the main thread.
              // TODO

              if (call.method.equals("getPaymentMetod")) {
                // "F5188DE7144C4DEBBF5CBF4262CD056A.uat01-vm-tx03"
                
                Set<String> paymentBrands = new LinkedHashSet<String>();
                paymentBrands.add("VISA");
                paymentBrands.add("MASTER");
                paymentBrands.add("DIRECTDEBIT_SEPA");

                CheckoutSettings checkoutSettings = new CheckoutSettings("8C9B453EC4DA8D0A1E3CE431EA13F60E.uat01-vm-tx01", paymentBrands, Connect.ProviderMode.TEST);

                // Set shopper result URL
                checkoutSettings.setShopperResultUrl("companyname://result");

                Intent intent = checkoutSettings.createCheckoutActivityIntent(this);
                startActivityForResult(intent, CheckoutActivity.REQUEST_CODE_CHECKOUT);

            
                    
            

              } else {
                result.notImplemented();
              }
            }
          );
    }




    
    @Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    switch (resultCode) {
        case CheckoutActivity.RESULT_OK:
            /* transaction completed */
            Transaction transaction = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_TRANSACTION);

            /* resource path if needed */
            String resourcePath = data.getStringExtra(CheckoutActivity.CHECKOUT_RESULT_RESOURCE_PATH);

            if (transaction.getTransactionType() == TransactionType.SYNC) {
                /* check the result of synchronous transaction */
                
            } else {
                /* wait for the asynchronous transaction callback in the onNewIntent() */
            }

            break;
        case CheckoutActivity.RESULT_CANCELED:
            /* shopper canceled the checkout process */
            break;
        case CheckoutActivity.RESULT_ERROR:
            /* error occurred */
            PaymentError error = data.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_ERROR);
    }
}



}
