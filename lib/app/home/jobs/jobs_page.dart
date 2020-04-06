import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker/app/home/job_entries/job_entries_page.dart';
import 'package:time_tracker/app/home/jobs/edit_job_page.dart';
import 'package:time_tracker/app/home/jobs/job_list_tile.dart';
import 'package:time_tracker/app/home/jobs/list_item_builder.dart';
import 'package:time_tracker/app/models/job.dart';
import 'package:time_tracker/app/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    final database = Provider.of<Database>(context, listen: false);
    try {
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Delete failed',
        exception: e,
      );
    }
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Jobs'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => EditJobPage.show(context, database: database),
          ),
        ],
      ),
      body: _buildContents(context),
    );
  }
}
