echo "***Creating nginx if not existing"
sudo cp -n /var/www/store.rem029.com/nginx/store /etc/nginx/sites-available/store
sudo cp -n /var/www/store.rem029.com/nginx/api.store /etc/nginx/sites-available/api.store

echo "***Linking nginx file"
cd /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/api.store
sudo ln -s /etc/nginx/sites-available/store
cd /var/www/store.rem029.com/

echo "***Verify and restart nginx"
sudo nginx -t
nginx -s reload
systemctl restart nginx

echo "***Run certbot"
certbot --nginx -d store.rem029.com --redirect --agree-tos --non-interactive
certbot --nginx -d api.store.rem029.com --redirect --agree-tos --non-interactive

echo "***Update packages"
yarn run bootstrap

echo "***Update database"
yarn migrate-latest

echo "***Start cron job"
yarn cron-add-issue

echo "***Start server if not started"
yarn start:pm2:staging

echo "***Reloading PM2 Application"
pm2 reload store-app-staging
pm2 reload store-add-issue-every-12hr

echo "***PM2 Update"
pm2 update