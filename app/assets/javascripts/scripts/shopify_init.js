(function(global) {
  'use strict';

  ShopifyApp.init({
      apiKey: global.SHOPIFY_API_KEY,
      shopOrigin: global.SHOPIFY_SHOP_ORIGIN,
      debug: global.SHOPIFY_DEBUG,
      forceRedirect: global.SHOPIFY_FORCE_REDIRECT
    });
})(window);
