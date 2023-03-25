echo "Update packages"
yarn run bootstrap

echo "Update database"
yarn migrate-latest

echo "Start cron job"
yarn cron-add-issue

echo "Start server if not started"
yarn start:pm2:staging

echo "Reloading PM2 Application"
pm2 reload store-app-staging
pm2 reload store-add-issue-every-12hr

echo "PM2 Update"
pm2 update

echo "Add nginx steps"

echo "Create nginx file"

echo "Link nginx file"

echo "Verify and restart nginx"

echo "Run certbot"